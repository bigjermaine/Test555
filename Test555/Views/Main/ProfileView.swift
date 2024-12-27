//
//  ProfileView.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//

import SwiftUI

import SwiftUI


struct ProfileView: View {
    @EnvironmentObject private var viewModel:RegisterViewModel
    @State private var isImagePickerPresented: Bool = false
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Updating...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                // Profile Image Picker
                VStack {
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    }
                    
                    Button("Change Profile Picture") {
                        isImagePickerPresented.toggle()
                    }
                    .padding(.top, 10)
                }
                
                // Name Text Field
                TextField("Name", text: $viewModel.name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Email Text Field
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Text(viewModel.location)
                               .font(.subheadline)
                               .foregroundColor(.gray)
                               .padding()
                
                // Update Button
                Button(action: {
                    viewModel.updateProfile()
                }) {
                    Text("Update Profile")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                .disabled(viewModel.isLoading)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(imageData: $viewModel.imageData, image: $viewModel.profileImage, isPresented: $isImagePickerPresented)
        }
        .onAppear {
            viewModel.fetchUserProfile()
            viewModel.updateLocation()
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    ProfileView()
        .environmentObject(navPreview)
        .environmentObject(previewViewModel)
}
