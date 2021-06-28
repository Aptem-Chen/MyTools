/* 
    通过 DotNet 实现对 json 的增删改查工作
*/
struct JsonTool
(
    private
    jsonDll = pathConfig.removePathLeaf(getThisScriptFilename()) + "\\.net\\Newtonsoft.Json.dll",
    existCheck = true,

    -- 私有构造方法：检查 .net/Newtonsoft.Json.dll 文件是否存在，如果不存在则抛出异常
    on create do (
        if doesFileExist jsonDll then (
            if getFileSize existCheck == 0 do (existCheck = false)
        ) else (existCheck = false)

        if not existCheck do (throw "File Error: .net/Newtonsoft.Json.dll doesn't exist.")
    ),

    public
    jsonReadFile = "",
    jsonWriteFile = "",

    fn readAll = (

    ),

    fn writeAll = (

    )
)

fn test = (
    JsonDllPath = @"D:\download\Json130r1\Bin\net45\Newtonsoft.Json.dll"
    JsonFilePath = @"D:\desktop\data.json"
    JsonWritePath = @"D:\desktop\jsonData.json"

    -- 读取本地Json文件到字符变量
    JsonString = ""
    JsonFile = openFile JsonFilePath
    while not eof JsonFile do(
        JsonString += readchar JsonFile
    )
    close JsonFile

    -- 加载模块
    (dotnetClass "System.Reflection.assembly").Load((dotnetClass "System.IO.File").ReadAllBytes(JsonDllPath))
    jsonControl = dotNetObject "Newtonsoft.Json.Linq.JObject"

    -- 解析Json格式的字符
    -- LinqJsonObj = (dotNetObject "Newtonsoft.Json.Linq.JObject").parse JsonString
    
    -- 输出对象的值
    -- OutValue = (LinqJsonObj.GetValue "Keys").Value

    -- 写出数据到 JsonWritePath
    jWriter = jsonControl.CreateWriter()

    jWriter.WriteStartObject();
    jWriter.WritePropertyName("CPU");
    jWriter.WriteValue("Intel");
    jWriter.WritePropertyName("PSU");
    jWriter.WriteValue("500W");
    jWriter.WritePropertyName("Drives");
    jWriter.WriteStartArray();
    jWriter.WriteValue("DVD read/writer");
    jWriter.WriteComment("(broken)");
    jWriter.WriteValue("500 gigabyte hard drive");
    jWriter.WriteValue("200 gigabyte hard drive");
    jWriter.WriteEnd();
    jWriter.WriteEndObject();

    jWriter.close()
)

test()