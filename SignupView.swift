import SwiftUI

struct SignupView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var newsletterOptIn = true
    @State private var showLogin = false
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Header()

                NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                    EmptyView()
                }
                .hidden()

                VStack(spacing: 16) {
                    TextField("Full name", text: $fullName)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))

                    TextField("Email address", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))

                    SecureField("Password", text: $password)
                        .textContentType(.newPassword)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))

                    SecureField("Confirm password", text: $confirmPassword)
                        .textContentType(.newPassword)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                }

                Toggle(isOn: $newsletterOptIn) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Keep me updated")
                            .font(.headline)
                        Text("Get class reminders, assignment updates, and helpful study tips.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))

                Button(action: submitSignup) {
                    Text("Create account")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Capsule().fill(Color.blue))
                        .foregroundColor(.white)
                }
                .disabled(!isFormValid)
                .opacity(isFormValid ? 1 : 0.6)

                Divider()
                    .padding(.vertical, 8)

                VStack(spacing: 12) {
                    Text("Already have an account?")
                        .foregroundStyle(.secondary)
                    Button(action: { showLogin = true }) {
                        Text("Log in")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.blue))
                    }
                }

                Spacer()
            }
            .padding(24)
            .sheet(isPresented: $showLogin) {
                LoginView(onLoginSuccess: handleAuthentication)
            }
        }
    }

    private var isFormValid: Bool {
        !fullName.isEmpty && email.contains("@") && password.count >= 8 && password == confirmPassword
    }

    private func submitSignup() {
        // Hook up signup API call here
        handleAuthentication()
    }

    private func handleAuthentication() {
        navigateToHome = true
        showLogin = false
    }
}

private struct Header: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Join Classfolio")
                .font(.largeTitle.weight(.bold))
            Text("Keep your classes, clubs, and deadlines organized in one place.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SignupView()
}
