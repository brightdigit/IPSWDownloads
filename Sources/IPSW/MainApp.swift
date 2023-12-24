import OpenAPIRuntime
import OpenAPIURLSession








@main
struct MainApp {
   static func main() async throws {
      let client = try Client(serverURL: Servers.server1(), transport: URLSessionTransport())
//       let ipswFiles = try await client.V_space_4_space__period__space_Keys_space_Device_space_List(
//         .init(path: .init(identifier: "VirtualMac2,1"))
//       )
      
      let ipswFiles = try await client.V_space_4_space__period__space_Get_space_Firmwares_space_For_space_Device(.init(path: .init(identifier:  "VirtualMac2,1"), query: .init(_type: "ipsw")))
      dump(ipswFiles)
    }
}
