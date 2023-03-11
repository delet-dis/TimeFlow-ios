//
//  LessonView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 10.03.2023.
//

import SwiftUI

struct LessonView: View {
    let displayingLesson: LessonResponse?

    private var backgroundColor: Color {
        if let lessonType = displayingLesson?.getType() {
            switch lessonType {
            case .lecture:
                return .init(uiColor: R.color.columbiaBlue() ?? .blue)
            case .seminar:
                return .init(uiColor: R.color.coral() ?? .red)
            case .practicalLesson:
                return .init(uiColor: R.color.lightGreen() ?? .green)
            case .laboratoryLesson:
                return .init(uiColor: R.color.flax() ?? .yellow)
            case .exam:
                return .init(uiColor: R.color.uclaBlue() ?? .blue)
            }
        } else {
            return .white
        }
    }

    private var textColor: Color {
        if let lessonType = displayingLesson?.getType() {
            switch lessonType {
            case .lecture, .laboratoryLesson:
                return .init(uiColor: R.color.lightenBlack() ?? .black)
            case .seminar, .practicalLesson, .exam:
                return .white
            }
        } else {
            return .init(uiColor: R.color.lightenBlack() ?? .black)
        }
    }

    private static let contentCornerRadius: CGFloat = 20

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
            }

            VStack {
                HStack {
                    Spacer()
                }

                HStack {
                    Text(displayingLesson?.subject.name ?? "")
                        .font(Font(R.font.ralewayBold(size: 18) ?? .systemFont(ofSize: 18, weight: .bold)))
                        .frame(minHeight: 50)
                        .foregroundColor(textColor)
                        .padding()
                        .padding(.top, -20)

                    Spacer()
                }
            }
            .padding(.vertical, 5)
            .padding(.bottom, 10)
            .background(backgroundColor.brightness(0.1))
            .modifier(CornerRadiusViewModifier(
                radius: Self.contentCornerRadius,
                corners: [.topLeft, .topRight]
            ))
            .overlay {
                VStack {
                    Spacer()

                    Rectangle()
                        .fill(backgroundColor)
                        .frame(height: 30)
                        .modifier(CornerRadiusViewModifier(
                            radius: Self.contentCornerRadius,
                            corners: [.topLeft, .topRight]
                        ))
                }
            }

            VStack(spacing: 0) {
                Group {
                    getLessonParameter(
                        systemImageName: "rectangle.inset.filled.and.person.filled",
                        text: displayingLesson?.teacher.name ?? ""
                    )
                    .padding(.horizontal, 10)

                    getLessonParameter(
                        systemImageName: "building.2",
                        text: displayingLesson?.classroom.number ?? ""
                    )
                    .padding(.horizontal, 10)
                    .background {
                        backgroundColor.brightness(-0.03)
                    }

                    getLessonParameter(
                        systemImageName: "person.2",
                        text: String(displayingLesson?.studentGroup.number ?? 0)
                    )
                    .padding(.horizontal, 10)
                    .background {
                        backgroundColor.brightness(-0.05)
                    }

                    HStack {
                        getLessonParameter(
                            systemImageName: "clock",
                            // siwftlint:disable:next line_length
                            text: "\(displayingLesson?.timeslot.beginTime ?? "") - \(displayingLesson?.timeslot.endTime ?? "")"
                        )

                        Divider()
                            .frame(height: 50)

                        getLessonParameter(
                            systemImageName: "list.bullet.rectangle.portrait",
                            text: String((displayingLesson?.timeslot.sequenceNumber ?? 0) + 1)
                        )
                        .padding(.leading, 5)
                    }
                    .padding(.horizontal, 10)
                    .background {
                        Rectangle()
                            .fill(backgroundColor)
                            .brightness(-0.08)
                            .padding(.bottom, 15)
                            .overlay {
                                VStack {
                                    Spacer()

                                    Rectangle()
                                        .fill(backgroundColor)
                                        .brightness(-0.08)
                                        .frame(height: 30)
                                        .modifier(CornerRadiusViewModifier(
                                            radius: Self.contentCornerRadius,
                                            corners: [.bottomLeft, .bottomRight]
                                        ))
                                }
                            }
                    }
                }
            }
            .padding(.top, -30)
        }
        .frame(minHeight: 200)
        .background {
            RoundedRectangle(cornerRadius: Self.contentCornerRadius)
                .fill(backgroundColor)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
        }
    }

    private func getLessonParameter(systemImageName: String, text: String) -> some View {
        HStack {
            Spacer()
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: systemImageName)
                        .font(.title3)
                        .foregroundColor(.black)
                }

            Spacer()
                .frame(width: 10)

            Text(text)
                .font(Font(R.font.ralewayMedium(size: 15) ?? .systemFont(ofSize: 15, weight: .medium)))
                .foregroundColor(.black)

            Spacer()
        }
        .frame(minHeight: 50)
    }
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        LessonView(displayingLesson: nil)
    }
}
