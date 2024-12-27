//
//  ImagePicker.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//


import SwiftUI
import UIKit

struct ImagePicker: View {
    @Binding var imageData: Data?
    @Binding var image: Image?
    @Binding var isPresented: Bool
    
    var body: some View {
        ImagePickerController(imageData: $imageData, image: $image, isPresented: $isPresented)
    }
}

struct ImagePickerController: UIViewControllerRepresentable {
    @Binding var imageData: Data?
    @Binding var image: Image?
    @Binding var isPresented: Bool
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerController
        
        init(parent: ImagePickerController) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: uiImage)
                parent.imageData = uiImage.jpegData(compressionQuality: 0.8)
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
