import SwiftUI

@MainActor
public class CodeMirrorViewModel: ObservableObject {
	
	/// Func to execute when text is load
    public var onLoadSuccess: (() -> Void)?
	
	/// Func to execute when loading is failed
    public var onLoadFailed: ((Error) -> Void)?
	
	/// Func to execute when text is modified
    public var onContentChange: (() -> Void)?

	/// Execute javascript code
    internal var executeJS: ((JavascriptFunction, JavascriptCallback?) -> Void)!

	/// DarkMode, default is setting on true
	@Published public var darkMode	  : Bool     = true
	@Published public var lineWrapping: Bool 	 = false
	@Published public var readOnly    : Bool     = false
    @Published public var language	  : Language = .json

	/// Execute javascript code in async mode
    private func executeJSAsync<T>(f: JavascriptFunction) async throws -> T? {
        return try await withCheckedThrowingContinuation { continuation in
            executeJS(f) { result in
                continuation.resume(with: result.map { $0 as? T })
            }
        }
    }

	/// Get text file modified
    public func getContent() async throws -> String? {
        try await executeJSAsync(f: JavascriptFunction(functionString: "CodeMirror.getContent()"))
    }

	/// Set text file open
    public func setContent(_ value: String) {
        executeJS(
            JavascriptFunction(
                functionString: "CodeMirror.setContent(value)",
                args: ["value": value]
            ),
            nil
        )
    }

    public init(
        onLoadSuccess: (() -> Void)? = nil,
        onLoadFailed: ((Error) -> Void)? = nil,
        onContentChange: (() -> Void)? = nil
    ) {
        self.onLoadSuccess = onLoadSuccess
        self.onLoadFailed = onLoadFailed
        self.onContentChange = onContentChange
    }
}
