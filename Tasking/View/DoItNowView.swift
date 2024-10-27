//
//  DoItNowView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct DoItNowView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @Environment(\.presentationMode) var presentationMode
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                List {
                    ForEach(taskManager.doItNowTasks) { task in
                        TapToCompleteTask(task: task) {
                            withAnimation {
                                taskManager.completeTask(for: task)
                                if let index = taskManager.doItNowTasks.firstIndex(where: { $0.id == task.id }) {
                                    taskManager.doItNowTasks.remove(at: index)
                                    taskManager.addCompletedTask(task)
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            Capsule()
                                .fill(Color.white)
                                .padding(2)
                        )
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            indexSet.forEach { index in
                                let task = taskManager.doItNowTasks[index]
                                taskManager.completeTask(for: task)
                                taskManager.doItNowTasks.remove(at: index)
                                taskManager.addCompletedTask(task)
                            }
                        }
                    }
                    .onMove { source, destination in
                        taskManager.doItNowTasks.move(fromOffsets: source, toOffset: destination)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(.clear)
                .onDisappear {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .cornerRadius(20)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Do It Now")
                        .font(CustomFont.title.font)
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            FoldingButtonBar(isExpanded: $isExpanded) { priority in
                                AnyView(taskManager.linkTo(for: priority))
                        }
            .padding(.bottom, 8)
        }
        .padding()
        .customizeSubviewsBackground(for: .green)
    }
}
struct TapToCompleteTask: View {
    @State private var isCompleted: Bool = false
    let task: Task
    let action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isCompleted.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        action()
                    }
                }
            }) {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isCompleted ? .green : .gray)
                    .font(.title)
            }
            .padding(.trailing, 8)
            
            Text(task.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(isCompleted ? 0.5 : 1)
                .font(CustomFont.body.font)
                .foregroundColor(Color.gray)
        }
        .contentShape(Rectangle())
    }
}
struct DoItNowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DoItNowView()
                .environmentObject(TaskManager())
        }
    }
}
