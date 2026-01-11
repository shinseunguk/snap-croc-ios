import SwiftUI
import ComposableArchitecture

public struct ContentView: View {
    public init() {}

    public var body: some View {
        LoginView(
            store: Store(
                initialState: LoginFeature.State()
            ) {
                LoginFeature()
            }
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
