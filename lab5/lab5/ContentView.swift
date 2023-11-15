import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var images: [UIImage] = []
    @State private var selectedImageIndex: Int = 0
    @State private var showImagePicker: Bool = false
    @State private var showAuthorInfo: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if images.isEmpty {
                    Text("No images selected")
                    
                } else {
                    Image(uiImage: images[selectedImageIndex])
                        .resizable()
                        .scaledToFit()
                    
                    HStack {
                        Button("Previous") {
                            withAnimation {
                                selectedImageIndex = max(selectedImageIndex - 1, 0)
                            }
                        }
                        .disabled(selectedImageIndex == 0)
                        
                        Button("Next") {
                            withAnimation {
                                selectedImageIndex = min(selectedImageIndex + 1, images.count - 1)
                            }
                        }
                        .disabled(selectedImageIndex == images.count - 1)
                    }
                }
                
                Spacer()
                
                HStack {
                    Button("Select Images") {
                        showImagePicker = true
                    }
                    
                    Button("About Author") {
                        showAuthorInfo = true
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                PhotoPicker(images: $images)
            }
            .sheet(isPresented: $showAuthorInfo) {
                AuthorInfoView()
            }
            .navigationTitle("Image Viewer")
        }
    }
}

#Preview {
    ContentView();
}
