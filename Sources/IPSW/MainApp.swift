//import OpenAPIRuntime
//import OpenAPIURLSession
//
//
//
//
//
//

import OpenAPIURLSession


@main
struct MainApp {
   static func main() async throws {
      let client = try Client(serverURL: Servers.server1(), transport: URLSessionTransport())
//       let ipswFiles = try await client.V_space_4_space__period__space_Keys_space_Device_space_List(
//         .init(path: .init(identifier: "VirtualMac2,1"))
//       )
      
      let response = try await client.firmwaresForDevice(.init(path: .init(identifier:  "VirtualMac2,1"), query: .init(_type: "ipsw")))
      //dump(ipswFiles)
     
     guard case let .case1(payload) = try response.ok.body.json else {
       return
     }
     guard let ipswFiles = payload.firmwares else {
       return
     }
     let result = try await withThrowingTaskGroup(of: Optional<Operations.ipswByIdentifierAndBuild.Output.Ok.Body.jsonPayload.Case1Payload>.self) { group in
       for ipswFile in ipswFiles {
         group.addTask {
           let json = try await  client.ipswByIdentifierAndBuild(.init(path: .init(identifier: "VirtualMac2,1", buildid: ipswFile.buildid))).ok.body.json
           guard case let .case1(firmware) = json else {
             return nil
           }
           return firmware
         }
       }
       return try await group.compactMap{$0}.reduce(into: [Operations.ipswByIdentifierAndBuild.Output.Ok.Body.jsonPayload.Case1Payload]()) { partialResult, item in
         partialResult.append(item)
       }
     }
     
     dump(result)
     
     
     
    }
}
