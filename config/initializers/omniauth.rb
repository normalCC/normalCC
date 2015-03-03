OmniAuth.config.logger = Rails.logger

#Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :google_oauth2, 
#  ENV["292190100162-ciubkct8f6gfdqlvmkf5p0fhlttbbbc3.apps.googleusercontent.com"], 
#  ENV["j859Q5zQu_o01Al-Lpc7hBAX"]
#end


#Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :google_oauth2, '292190100162-ciubkct8f6gfdqlvmkf5p0fhlttbbbc3.apps.googleusercontent.com',
# 'j859Q5zQu_o01Al-Lpc7hBAX',
# {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
#end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '292190100162-ciubkct8f6gfdqlvmkf5p0fhlttbbbc3.apps.googleusercontent.com',
 'j859Q5zQu_o01Al-Lpc7hBAX',

{client_options: {
    #:provider => "google_oauth2",
    #:uid => "123456789",
    #:info => {
        :password => "pizza",
        :name => "John Doe",
        :email => "john@company_name.com",
    }}
    #:credentials => {
     #   :token => "token",
      #  :refresh_token => "another_token",
       # :expires_at => 1354920555,
        #:expires => true
    #},
    #:extra => {
     #   :raw_info => {
      #      #:sub => "123456789",
       #     :email => "user@domain.example.com",
        #    :email_verified => true,
         #   :name => "John Doe",
            #:given_name => "John",
            #:family_name => "Doe",
            #:profile => "https://plus.google.com/123456789",
            #:picture => "https://lh3.googleusercontent.com/url/photo.jpg",
          #  :gender => "male",
           # :birthday => "0000-06-25",
            #:locale => "en",
            #:hd => "company_name.com"
       # }
   # }
#}
end