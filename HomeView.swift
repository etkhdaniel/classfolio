import SwiftUI

struct HomeView: View {
    struct ClassInfo: Identifiable {
        let id = UUID()
        let name: String
        let instructor: String
        let schedule: String
        let color: Color
    }

    struct Semester: Identifiable {
        let id = UUID()
        let name: String
        let classes: [ClassInfo]
    }

    private let currentClasses: [ClassInfo] = [
        .init(name: "Algorithms", instructor: "Dr. Lee", schedule: "Mon & Wed · 10:30 AM", color: .blue.opacity(0.2)),
        .init(name: "Modern Art History", instructor: "Prof. Alvarez", schedule: "Tue & Thu · 1:00 PM", color: .purple.opacity(0.2)),
        .init(name: "Data Visualization", instructor: "Dr. Patel", schedule: "Fri · 9:00 AM", color: .green.opacity(0.2))
    ]

    private let previousSemesters: [Semester] = [
        Semester(
            name: "Fall 2023",
            classes: [
                .init(name: "Mobile Development", instructor: "Dr. Kim", schedule: "Completed", color: .orange.opacity(0.2)),
                .init(name: "Linear Algebra", instructor: "Dr. Chen", schedule: "Completed", color: .pink.opacity(0.2))
            ]
        ),
        Semester(
            name: "Spring 2023",
            classes: [
                .init(name: "Cognitive Science", instructor: "Dr. Harris", schedule: "Completed", color: .yellow.opacity(0.2)),
                .init(name: "Sociology of Education", instructor: "Prof. Gardner", schedule: "Completed", color: .teal.opacity(0.2))
            ]
        )
    ]

    @State private var selectedSemesterIndex = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header

                    sectionHeader(title: "This semester", subtitle: "Your active classes")

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                        ForEach(currentClasses) { course in
                            ClassCard(course: course)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Previous classes")
                                    .font(.title3.weight(.semibold))
                                Text("Switch between earlier semesters")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Menu {
                                Picker("Semester", selection: $selectedSemesterIndex) {
                                    ForEach(Array(previousSemesters.enumerated()), id: \.offset) { index, semester in
                                        Text(semester.name).tag(index)
                                    }
                                }
                            } label: {
                                HStack(spacing: 8) {
                                    Text(previousSemesters[selectedSemesterIndex].name)
                                        .fontWeight(.semibold)
                                    Image(systemName: "chevron.up.chevron.down")
                                        .font(.footnote)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                            }
                        }

                        VStack(spacing: 12) {
                            ForEach(previousSemesters[selectedSemesterIndex].classes) { course in
                                HStack(spacing: 16) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(course.color)
                                        .frame(width: 52, height: 52)
                                        .overlay(
                                            Image(systemName: "book.closed")
                                                .foregroundStyle(.primary)
                                        )

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(course.name)
                                            .font(.headline)
                                        Text(course.instructor)
                                            .foregroundStyle(.secondary)
                                        Text(course.schedule)
                                            .font(.footnote)
                                            .foregroundStyle(.secondary)
                                    }

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.secondary)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)))
                            }
                        }
                    }
                }
                .padding(24)
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Notifications action
                    } label: {
                        Image(systemName: "bell")
                    }
                }
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome back")
                .font(.largeTitle.weight(.bold))
            Text("Track your current workload and quickly revisit completed courses.")
                .foregroundStyle(.secondary)
        }
    }

    private func sectionHeader(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.title3.weight(.semibold))
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

private struct ClassCard: View {
    let course: HomeView.ClassInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(course.color)
                .frame(height: 80)
                .overlay(
                    Image(systemName: "graduationcap")
                        .font(.title)
                        .foregroundStyle(.primary)
                )

            Text(course.name)
                .font(.headline)
            Text(course.instructor)
                .foregroundStyle(.secondary)
            Text(course.schedule)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)))
    }
}

#Preview {
    HomeView()
}
