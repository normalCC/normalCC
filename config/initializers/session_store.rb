# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_normalcc_session'
Rails.application.config.session_store :cookie_store,
                                             key: '_normalcc_session', 
                                             :key => '_normalcc_session',
                                             :expire_after => 1.hour