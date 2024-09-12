//
//  HapticManager.swift
//
//  Created by Kevin Green on 4/29/24.
//

import SwiftUI
import CoreHaptics

@available(iOS 14.0, *)
public class HapticManager {
    
    static let instance = HapticManager()
        
    /// Checks if the device supports haptics.
    var isSupported: Bool {
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        return hapticCapability.supportsHaptics
    }
    
    private init() {}
    
    /// Plays a standard haptic notification feedback.
    /// - Parameter type: A notification feedback type.
    ///
    /// ```
    ///     if allowHaptics {
    ///         HapticManager.instance.feedback(.warning)
    ///     }
    /// ```
    func feedback(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    /// Plays a standard haptic notification feedback.
    /// - Parameters:
    ///   - style: A notification feedback type.
    ///   - intensity: An value specifying how intense the feedback is.
    ///
    /// ```
    ///     if allowHaptics {
    ///         HapticManager.instance.feedback(.warning)
    ///     }
    /// ```
    func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle, intensity: CGFloat? = nil) {
        let generator = UIImpactFeedbackGenerator(style: style)
        intensity != nil ? generator.impactOccurred(intensity: intensity!) : generator.impactOccurred()
    }

}


@available(iOS 14.0, *)
public extension View {
    
    /// A pre-iOS 17 "notification" haptic feedback view modifier that triggers whith the passed in trigger argument and condition.
    /// - Parameters:
    ///   - style: The style of the generator feedback.
    ///   - trigger: The value in which triggers the feedback to play.
    ///   - condition: A conditional closure to allow or not the haptic generator's feedback.
    ///
    /// ```
    ///     .haptic(type: .warning, trigger: currentPage) { value in
    ///         // conditional statement here...
    ///         allowsHaptics ? true : false
    ///     }
    /// ```
    @ViewBuilder func haptic<T: Equatable>(feedback type: UINotificationFeedbackGenerator.FeedbackType, trigger: T, condition: @escaping (T) -> Bool) -> some View {
        if HapticManager.instance.isSupported && condition(trigger) == true {
            if #available(iOS 17.0, *) {
                self.onChange(of: trigger) { _, _ in
                    HapticManager.instance.feedback(type)
                }
            } else {
                // Fallback on earlier versions
                self.onChange(of: trigger) { _ in
                    HapticManager.instance.feedback(type)
                }
            }
        } else {
            self
        }
    }
    
    /// A pre-iOS 17 "impact" haptic feedback view modifier that triggers whith the passed in trigger argument and condition.
    /// - Parameters:
    ///   - style: The style of the generator feedback.
    ///   - intensity: An optional intensity value for the feedback.
    ///   - trigger: The value in which triggers the feedback to play.
    ///   - condition: A conditional closure to allow or not the haptic generator's feedback.
    ///
    /// ```
    ///     .haptic(impact: .light, intensity: 1, trigger: currentPage) { value in
    ///         // conditional statement here...
    ///         allowsHaptics ? true : false
    ///     }
    /// ```
    @ViewBuilder func haptic<T: Equatable>(impact style: UIImpactFeedbackGenerator.FeedbackStyle, intensity: CGFloat? = nil, trigger: T, condition: @escaping (T) -> Bool) -> some View {
        let HM = HapticManager.instance
        if HM.isSupported && condition(trigger) == true {
            if #available(iOS 17.0, *) {
                self.onChange(of: trigger) { _, _ in
                    intensity != nil ? HM.impact(style, intensity: intensity!) : HM.impact(style)
                }
            } else {
                // Fallback on earlier versions
                self.onChange(of: trigger) { _ in
                    intensity != nil ? HM.impact(style, intensity: intensity!) : HM.impact(style)
                }
            }
        } else {
            self
        }
    }
    
}

