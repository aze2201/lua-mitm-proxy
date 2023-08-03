function on_fly (url, body, header)
            local stream_body = 'no content'
            -- library for decompress body
            local zlib = require "zlib"
            local brotlidec = require "brotli.decoder"
            -- if no header define something to avoid nil value
            if not header then
                 header='xxx'
            end
            -- need to decompress if no Content-Encoding specified
            if string.find(body, "DOCTYPE") then
                if string.find(header, "gzip") then                   
                    local stream = zlib.inflate()
                    local stream_body = stream(body)
                elseif string.find(header, "br") then
                    local decoder = brotlidec:new()
                    local stream_body, err = decoder:decompress(body)
                else
                        stream_body = body
                end
            end
            -- else
            --    print ('no header provided for this URL ',url)
            -- end

            -- here you can add any operation. Like printing, mailing etc.
            print(stream_body)

end
