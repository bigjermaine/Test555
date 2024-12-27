//
//  CustomTextField.swift
//  JIVApp
//
//  Created by MacBook AIR on 28/11/2024.
//

import SwiftUI
struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var backgroundColor: Color = Color(.systemGray6) // Default background
    var cornerRadius: CGFloat = 7.0
    var textColor: Color = .white // Default text color
    var placeholderColor: Color = .gray // Placeholder color
    @FocusState private var isFocused: Bool
    var body: some View {
        ZStack {
            backgroundColor
                .cornerRadius(cornerRadius)
                .frame(height: 58)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(isFocused ? Color.blue : .color7A7A7A, lineWidth: isFocused ? 2 : 0.5)
                )

            TextField(placeholder, text: $text)
                .focused($isFocused) // Bind focus state
                .foregroundColor(textColor)
                .textInputAutocapitalization(.never)
                .placeholder(when: text.isEmpty) {
                    Text(placeholder)
                        .foregroundColor(placeholderColor)
                        .font(.body)
                        .padding(.horizontal)
                }
                .padding(.horizontal)
        }
    }
}

extension View {
    /// Adds a placeholder modifier for `TextField`
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder content: () -> Content
    ) -> some View {
        overlay(
            Group {
                if shouldShow {
                    content()
                }
            },
            alignment: alignment
        )
    }
}


import SwiftUI

struct SecretCustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var backgroundColor: Color = Color(.systemGray6) // Default background
    var cornerRadius: CGFloat = 7.0
    var textColor: Color = .white // Default text color
    var placeholderColor: Color = .gray // Placeholder color
    var borderColor: Color = .gray // Default border color
    var borderWidth: CGFloat = 0.5 // Default border width
    @FocusState private var isFocused: Bool
    @State private var isSecure: Bool = true // Tracks if password is hidden

    var body: some View {
        ZStack {
            backgroundColor
                .cornerRadius(cornerRadius) // Rounded corners
                .frame(height: 58) // Fixed height for consistency
                .overlay( // Add border overlay
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(isFocused ? Color.blue : .color7A7A7A, lineWidth: isFocused ? 2 : 0.5)
                )

            HStack {
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .textInputAutocapitalization(.never)
                        .focused($isFocused) // Bind focus state
                        .foregroundColor(textColor)
                        .padding(.horizontal, 12)
                        .placeholder(when: text.isEmpty) {
                            Text(placeholder)
                                .foregroundColor(placeholderColor)
                                .font(.body)
                                .padding(.horizontal)
                        }
                } else {
                    TextField(placeholder, text: $text)
                        .textInputAutocapitalization(.never)
                        .foregroundColor(textColor)
                        .padding(.horizontal, 12)
                        .placeholder(when: text.isEmpty) {
                            Text(placeholder)
                                .foregroundColor(placeholderColor)
                                .font(.body)
                                .padding(.horizontal)
                        }
                }
                
                Button(action: {
                    isSecure.toggle() // Toggle visibility
                }) {
                    Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray) // Eye icon color
                        .padding(.trailing, 12) // Padding for the button
                }
            }
        }
    }
}
