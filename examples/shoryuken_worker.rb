class ShoryukenWorker
  include Shoryuken::Worker

  shoryuken_options queue: 'shoryuken', auto_delete: true

  def perform(sqs_msg)
    puts "Shoryuken: '#{sqs_msg.body}'"
  end
end