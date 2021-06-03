/*
    该脚本用来修改资源路径
*/

fn png2jpg = (
    -- 将png资源路径改为jpg
    try (
        count = 0
        while true do (
            tex = AssetManager.GetAssetByIndex count
            texFullName = tex.GetFullFilePath()
            count += 1
            print texFullName
        )
    ) catch (ok)
    

fn main = (
    png2jpg()
)

main()
