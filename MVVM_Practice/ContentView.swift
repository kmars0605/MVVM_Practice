import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                    .frame(height: 200)
                HStack{
                    Spacer()
                    TextField("", text: $viewModel.leftText)
                        .frame(width: geometry.size.width * 0.4, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)

                    Spacer()
                    TextField("", text: $viewModel.rightText)
                        .frame(width: geometry.size.width * 0.4, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                    Spacer()
                }
                Spacer()
                    .frame(height: 40)
                Button(action: {
                    guard let leftNumber = Float(viewModel.leftText), let rightNumber = Float(viewModel.rightText) else {
                        viewModel.showingAlert = true
                        return
                    }
                    viewModel.setResultLabel(text: String(format: "%.1f", viewModel.model.multiply(leftNumber, rightNumber)))
                }){
                    Text("=")
                        .foregroundColor(.black)
                        .font(.system(size: 38))

                }
                .frame(width: geometry.size.width * 0.6, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .disabled(viewModel.changeResultButtonEnable())
                .alert(isPresented: $viewModel.showingAlert, content: {
                    Alert(title: Text("エラー"),
                          message: Text("数字を入れてください"))
                })
                Spacer().frame(height: 40)
                Text(viewModel.result ?? "")
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
