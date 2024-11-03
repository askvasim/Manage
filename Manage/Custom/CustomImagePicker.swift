//
//  CustomImagePicker.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import UIKit

struct CustomImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage?
    @Binding var imageName: String
    @Binding var imageExtention: String
    @Binding var imagePath: URL
    @State var handle: (Bool) -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<CustomImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_: UIImagePickerController, context _: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CustomImagePicker
        init(_ parent: CustomImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            if (info[UIImagePickerController.InfoKey.imageURL] as? URL) != nil {
                let path = (NSTemporaryDirectory() as NSString).appendingPathComponent("imageName.png")
                let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                let data = image.pngData()! as NSData
                data.write(toFile: path, atomically: true)
                let photoURL = URL(fileURLWithPath: path)
                let photoName = photoURL.lastPathComponent
                let filename: NSString = photoName as NSString
                let pathExtention = filename.pathExtension
                let pathPrefix = filename.deletingPathExtension
                parent.imagePath = photoURL
                parent.imageName = pathPrefix
                parent.imageExtention = pathExtention
            }
            parent.handle(true)
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
