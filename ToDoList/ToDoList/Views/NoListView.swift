import SwiftUI

struct NoListView: View {
    
    @State var showGroundback: Bool = false
    @EnvironmentObject var vm: ListsViewModel
    @State var startColor: Color = .purple.opacity(0.8)
    @State var endColor: Color = .yellow.opacity(0.8)
    
    var body: some View {
        ZStack {
            ScrollView {
                Text("嗨，新朋友！欢迎加入速记 —— 让待办管理快到飞起的效率工具～ 从此告别脑子记不住、琐事堆成山的烦恼！速记的核心就是 “快”：点击“+”号就能添加任务，语音、文字随你选，不用复杂设置。重要事项置顶，到期自动提醒，再也不会错过约会、工作节点。界面干净无冗余，分类归档清晰，学习、工作、生活待办一键区分。第一次用超简单：现在就点击底部“+”，创建你的第一个待办吧！完成后就能解锁进度追踪功能，看着任务一个个打勾，成就感直接拉满～有任何问题，随时在设置里找帮助，我们一直都在。")
                    .font(.system(size: 24, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(15)
                    .multilineTextAlignment(.leading)
                    .background(LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(20)
                    .padding()
                    .shadow(radius: 5)
                
                NavigationLink {
                    AddView()
                        .environmentObject(vm)
                } label: {
                    Text("START")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(showGroundback ? Color.red : Color.orange )
                        .cornerRadius(50)
                        .padding(showGroundback ? 10 : 30)
                        .shadow(
                            color: showGroundback ? Color.red.opacity(0.6) : Color.orange.opacity(0.6),
                            radius: showGroundback ? 40 : 20,
                            y: showGroundback ? 10 : 20
                        )
                        .offset(y: showGroundback ? -10 : 0)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    withAnimation(
                        Animation
                            .easeInOut(duration: 2)
                            .repeatForever(autoreverses: true)
                    ) {
                        showGroundback.toggle()
                    }
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoListView()
            .navigationTitle(Text("Welcome to SuJi!"))
    }
}
