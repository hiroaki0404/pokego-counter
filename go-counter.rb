require 'sinatra'
require 'line/bot'
require 'rtesseract'
require 'pp'

def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_id = ENV["LINE_CHANNEL_ID"]
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
end

def decode_image(path)
    image = RTesseract.new(path, tessdata_dir: ENV["TESSDATA_DIR"], oem: true)
    pp image
    image.to_s
end

get '/' do
    return "OK"
end

post '/count' do
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
        error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image
          response = client.get_message_content(event.message['id'])
          tf = Tempfile.open("content")
          tf.write(response.body)
          tf.close
          msg = decode_image(tf.path)
          message = {
              type: 'text',
              text: msg
          }
          client.reply_message(event['replyToken'], message)
          File.delete(tf.path)
        end
      end
    end
  
    "OK"  
end
