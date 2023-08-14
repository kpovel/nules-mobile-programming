import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack (alignment: .center) {
            Text("Лабораторна робота №1")
                .font(.title)
                .fontWeight(.heavy)
                .padding(.bottom, 30)
            VStack (alignment: .leading, spacing: 30) {
                VStack (alignment: .leading){
                    Text("Author:")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Карась Павло Петрович")
                        .font(.headline)
                }
                VStack(alignment: .leading){
                    Text("Спеціальність:")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Інженерія програмного забезпечення")
                        .font(.headline)
                }
                VStack(alignment: .leading) {
                    Text("Номер курсу і групи:")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Інженерія програмного забезпечення")
                        .font(.headline)
                }
                VStack (alignment: .leading){
                    Text("Очікування від навчального курсу: ")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Очікую вміло навчитась розроблювати мобільні застосунки")
                        .font(.headline)
                }
            }
            Spacer()
        }
        
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
