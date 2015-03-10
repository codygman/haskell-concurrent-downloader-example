import System.Log.Logger
import System.IO
import Network.Wreq
import Control.Lens (view)
import qualified Data.ByteString.Lazy as BS
import Control.Concurrent.Async

downloadUrl :: String -> IO ()
downloadUrl url = do
  updateGlobalLogger "DownloaderApp" (setLevel INFO)
  infoM "DownloaderApp" ("Downloading: " ++ url)
  response <- get url
  BS.writeFile fileName (view responseBody response)
  infoM "DownloaderApp" ("Downloaded " ++ url ++ " to " ++ fileName)
    where fileName = "/tmp/lastDownloadedFile"

main = do
  mapConcurrently downloadUrl [ "http://www.google.com"
                              , "http://www.reddit.com"
                              , "http://www.github.com"
                              ]
  
