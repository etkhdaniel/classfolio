import SwiftUI

struct LoginView: View {
    var onLoginSuccess: () -> Void = {}
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var staySignedIn = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Capsule()
                    .frame(width: 36, height: 4)
                    .foregroundStyle(.secondary)
                    .padding(.top, 8)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome back")
                        .font(.title.weight(.semibold))
                    Text("Log in to pick up where you left off with your classes and clubs.")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 16) {
                    TextField("Email address", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))

                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                }

                Toggle("Keep me signed in", isOn: $staySignedIn)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))

                Button(action: submitLogin) {
                    Text("Log in")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Capsule().fill(Color.blue))
                        .foregroundColor(.white)
                }
                .disabled(!isFormValid)
                .opacity(isFormValid ? 1 : 0.6)

                Button("Forgot password?") {
                    // Hook up password reset flow
                }
                .foregroundStyle(.blue)

                Spacer()
            }
            .padding(24)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "chevron.backward")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }

    private var isFormValid: Bool {
        email.contains("@") && password.count >= 8
    }

    private func submitLogin() {
        // Hook up login API call here
        onLoginSuccess()
        dismiss()
    }
}

#Preview {
    LoginView()
}
