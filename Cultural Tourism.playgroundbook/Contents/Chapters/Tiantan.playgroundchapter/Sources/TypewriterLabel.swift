// TypewriterLabel.swift
// Created by Yang Li on 31/03/2018.
//
// Copyright © 2018 Yang Li, Tongji University, Shanghai.
// All rights reserved.
//

import UIKit

public class TypewriterLabel: UILabel {
    
    public var typingTimeInterval: TimeInterval = 0.1    
    private var animationTimer: Timer?
    public var hideTextBeforeTypewritingAnimation = true {
        didSet {
            configureTransparency()
        }
    }
    private var utf16CharacterLocation = 0

    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        configureTransparency()
    }
    
    deinit {
        animationTimer?.invalidate()
    }
    
    public func startTypewritingAnimation(completion: (() -> Void)?) {
        guard let attributedText = attributedText else {
            return
        }
        
        setAttributedTextColorToTransparent()
        stopTypewritingAnimation()
        var animateUntilCharacterIndex = 0
        let charactersCount = attributedText.string.count
        utf16CharacterLocation = 0
        
        animationTimer = Timer.scheduledTimer(withTimeInterval: typingTimeInterval, repeats: true, block: { (timer: Timer) in
            if animateUntilCharacterIndex < charactersCount {
                self.setAlphaOnAttributedText(alpha: CGFloat(1), characterIndex: animateUntilCharacterIndex)
                animateUntilCharacterIndex += 1
            } else {
                completion?()
                self.stopTypewritingAnimation()
            }
        })
    }
    
    public func stopTypewritingAnimation() {
        animationTimer?.invalidate()
        animationTimer = nil
    }
    
    public func cancelTypewritingAnimation(clearText: Bool = true) {
        if clearText {
            setAttributedTextColorToTransparent()
        }
        stopTypewritingAnimation()
    }
    
    private func configureTransparency() {
        if hideTextBeforeTypewritingAnimation {
            setAttributedTextColorToTransparent()
        } else {
            setAttributedTextColorToOpaque()
        }
    }
    
    private func setAttributedTextColorToTransparent() {
        if hideTextBeforeTypewritingAnimation {
            setAlphaOnAttributedText(alpha: CGFloat(0))
        }
    }

    private func setAttributedTextColorToOpaque() {
        if !hideTextBeforeTypewritingAnimation {
            setAlphaOnAttributedText(alpha: CGFloat(1))
        }
    }

    private func setAlphaOnAttributedText(alpha: CGFloat) {
        guard let attributedText = attributedText else {
            return
        }
        
        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        attributedString.addAttribute(.foregroundColor, value: textColor.withAlphaComponent(alpha), range: NSRange(location:0, length: attributedString.length))
        self.attributedText = attributedString
    }

    private func setAlphaOnAttributedText(alpha: CGFloat, characterIndex: Int) {
        guard let attributedText = attributedText else {
            return
        }
        
        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        let index = attributedString.string.index(attributedString.string.startIndex, offsetBy: characterIndex)
        let character = "\(attributedString.string[index])"
        let count = character.utf16.count
        attributedString.addAttribute(.foregroundColor, value: textColor.withAlphaComponent(alpha), range: NSRange(location: utf16CharacterLocation, length: count))
        self.attributedText = attributedString
        
        utf16CharacterLocation += count
    }
}
