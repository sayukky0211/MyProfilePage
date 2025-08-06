# ビルド用のイメージ
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# プロジェクトファイルをコピーしてリストア＆ビルド
COPY . ./
RUN dotnet publish -c Release -o out

# 実行用の軽量ランタイムイメージ
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out .

# アプリ実行コマンド（プロジェクト名.dllに変えてね！）
ENTRYPOINT ["dotnet", "MyProfilePage.dll"]
