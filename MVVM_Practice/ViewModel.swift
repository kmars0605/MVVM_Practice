import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var model: Model!
    @Published var leftText = ""
    @Published var rightText = ""
    @Published var result : String?
    @Published var showingAlert = false  
    var cancellable: Cancellable?

    func inject(model: Model) {
        self.model = model
    }

    func setResultLabel(text: String) {
        result = text
    }
    func changeResultButtonEnable() -> Bool{
        if leftText == "" || rightText == "" {
            //未入力あり
            return true
        } else {
            //入力完了
            return false
        }
    }
}
