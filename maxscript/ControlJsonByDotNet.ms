/* 
    通过 DotNet 实现对 json 的增删改查工作
*/
-- TODO: 未写完，结合下面的测试范例，只是实现了最基本的增查功能，还需要进一步完善
struct JsonTool
(
    private
    jsonReadFile = "",
    jsonWriteFile = "",

    jsonDll = pathConfig.removePathLeaf(getThisScriptFilename()) + "\\.net\\Newtonsoft.Json.dll",
    existCheck = true,

    jsonControl = undefined,

    -- 类似构造方法，实例化对象的时候会自动执行：检查 .net/Newtonsoft.Json.dll 文件是否存在，如果不存在则抛出异常
    on create do 
    (
        if doesFileExist this.jsonDll then 
        (
            if getFileSize this.jsonDll == 0 do (this.existCheck = false)
        ) else (this.existCheck = false)

        if not this.existCheck do (throw "File Error: .net/Newtonsoft.Json.dll doesn't exist.")

        (dotnetClass "System.Reflection.assembly").Load((dotnetClass "System.IO.File").ReadAllBytes(jsonDll))
        jsonControl = dotNetObject "Newtonsoft.Json.Linq.JObject"
    ),

    -- 检查文件路径是否存在的方法，不存在则创建之
    fn checkDir dirPath = 
    (
        /* 
            目前该函数存在一个缺陷：doesDiretoryExist() 无法区分文件和文件夹，如果有同名文件，该方法也会返回true
                                                                            ———— 2021.6.29
        */
        if not doesDirectoryExist dirPath do (makeDir dirpath)
    ),

    public
    fn getJsonReadFile = 
    (
        this.jsonReadFile
    ),

    fn getJsonWriteFile = 
    (
        this.jsonWriteFile
    ),

    fn setJsonReadFile readFile = 
    (
        this.jsonReadFile = readFile
    ),

    fn setJsonWriteFile writeFile = 
    (
        this.jsonWriteFile = writeFile
    ),

    fn getJsonData = 
    (
        jsonString = ""
        jsonFile = openFile this.jsonReadFile
        while not eof jsonFile do
        (
            jsonString += readchar jsonFile
        )
        close jsonFile
        
        try (
            jsonData = (dotNetObject "Newtonsoft.Json.Linq.JObject").parse jsonString
        ) catch (
            jsonData = (dotNetObject "Newtonsoft.Json.Linq.JArray").parse jsonString
        )

        jsonData
    ),

    -- TODO: 这只是一个测试示例，具体实现还需要更改
    fn writeAll jsonStringData = 
    (
        -- this.checkDir this.jsonWriteFile

        videogameRatings = dotNetObject "Newtonsoft.Json.Linq.JObject" #(
            dotNetObject "Newtonsoft.Json.Linq.JProperty" "Halo" 9,
            dotNetObject "Newtonsoft.Json.Linq.JProperty" "Starcraft" 9,
            dotNetObject "Newtonsoft.Json.Linq.JProperty" "Call of Duty" 7.5
        )
        
        jsonStr = videogameRatings.ToString()
        
        jsonFile = @"D:\temp\code test\videogameRatings.json"
        if not doesFileExist jsonFile do
        (
            try
            (
                jFileStream = createfile jsonFile encoding:#utf8
                format jsonStr to:jFileStream
            )catch(format "[ERROR]%\r\n" (getCurrentException()))
                
            close jFileStream
        )
        
    )
)

-- 测试函数
fn test = 
(
    jTool = JsonTool()
    flag = false

    if flag then
    (
        -- Read json test.
        jTool.setJsonReadFile @"D:\temp\code test\ReadData.json"
        jsonData = jTool.getJsonData()
        print jsonData
    )
    else 
    (
        -- Write json test.
        jTool.setJsonWriteFile = @"D:\temp\code test\subDir\WriteData.json"
    ) 
)

test()