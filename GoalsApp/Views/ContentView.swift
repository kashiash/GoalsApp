//
//  ContentView.swift
//  GoalsApp
//
//  Created by DevTechie on 10/1/21.
//

import SwiftUI

struct ContentView: View {
    
    private var repo: GoalRepositoryProtocol
    
    @ObservedObject var goalListViewModel: GoalListViewModel
    
    @State private var isEditing = false
    @State private var showAddNewGoal = false
    
    init(repo: GoalRepositoryProtocol) {
        self.repo = repo
        
        goalListViewModel = GoalListViewModel(repo: repo)
        Theme.navigationBarColors(background: .clear, titleColor: .black, tintColor: .white)
    }
    
    private var goalItems: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    private func deleteButton(goal: GoalViewModel) -> some View {
        Button {
            goalListViewModel.deleteGoal(goalId: goal.id)
        } label: {
            Image(systemName: "minus.circle.fill")
        }
        .font(.title)
        .foregroundColor(isEditing ? .red : .clear)
        .offset(x: -90, y: -70)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: goalItems, spacing: 10) {
                        ForEach(goalListViewModel.goals, id: \.id) { goal in
                            NavigationLink(destination: GoalDetailView(goalDetailViewModel: GoalDetailViewModel(repo: repo, goal: goal))) {
                                
                                GoalView(goalViewModel: goal)
                                    .rotationEffect(.degrees(isEditing ? 2.5 : 0))
                                    .animation(Animation.easeInOut(duration: 0.12).repeat(while: isEditing), value: isEditing)
                                    .disabled(isEditing)
                                    .overlay(deleteButton(goal: goal))
                                
                            }
                        }
                    }.padding(.horizontal)
                }
                .onAppear {
                    goalListViewModel.getAllGoals()
                }
                .navigationTitle("Goals")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isEditing.toggle()
                        }) {
                            Text(isEditing ? "Done" : "Edit")
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                Button(action: {
                    showAddNewGoal = true
                }) {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 64))
                        .shadow(radius: 5)
                        .clipped()
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 20)
                .opacity(isEditing ? 0.0 : 1.0)
                
                .fullScreenCover(isPresented: $showAddNewGoal) {
                    goalListViewModel.getAllGoals()
                } content: {
                    AddNewGoal(repo: repo)
                }

            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(repo: MockGoalRepository())
    }
}
