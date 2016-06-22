Facebook request.env['omniauth.auth']:

{
  :provider => 'facebook',
  :uid => '1234567',
  :info => {
    :email => 'joe@bloggs.com',
    :name => 'Joe Bloggs',
    :first_name => 'Joe',
    :last_name => 'Bloggs',
    :image => 'http://graph.facebook.com/1234567/picture?type=square',
    :urls => { :Facebook => 'http://www.facebook.com/jbloggs' },
    :location => 'Palo Alto, California',
    :verified => true
  },
  :credentials => {
    :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
    :expires_at => 1321747205, # when the access token expires (it always will)
    :expires => true # this will always be true
  },
  :extra => {
    :raw_info => {
      :id => '1234567',
      :name => 'Joe Bloggs',
      :first_name => 'Joe',
      :last_name => 'Bloggs',
      :link => 'http://www.facebook.com/jbloggs',
      :username => 'jbloggs',
      :location => { :id => '123456789', :name => 'Palo Alto, California' },
      :gender => 'male',
      :email => 'joe@bloggs.com',
      :timezone => -8,
      :locale => 'en_US',
      :verified => true,
      :updated_time => '2011-11-11T06:21:03+0000'
    }
  }
}

recipes#new params:

{
  "recipe"=>{
    "image"=>
      #<ActionDispatch::Http::UploadedFile:0x007faf51a432d0 @tempfile=#<Tempfile:/var/folders/mr/qf7hjkc14w7gvrfwydkhk6c40000gn/T/RackMultipart20160622-581-loblxr.jpg>, @original_filename="fruit-platter.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"recipe[image]\"; filename=\"fruit-platter.jpg\"\r\nContent-Type: image/jpeg\r\n">, 
    "title"=>
      "Fruit Platter", 
    "description"=>
      "This is a great summer dish - or basically any-time-of-year dish. As a better-eating tip, get the organic fruits at your local farmers' market to avoid pesticides and support your local growers. Suggested fruits are in the instructions, but use your imagination and pick anything you like!", 
    "instruction"=>
      "Chop all selected fruits into pieces that are easy to pick-up with a fork or toothpick. Arrange on a tray or platter - this is another place you can show your design skill or pizzazz.", 
    "ingredients_attributes"=>{
      "1466598742270"=>{
        "amount"=>"1/2 pound", 
        "item_attributes"=>{
          "name"=>"Strawberry"
          }, 
        "_destroy"=>"false"},
      "1466598752602"=>{
        "amount"=>"4", 
        "item_attributes"=>{
          "name"=>"Kiwi"
          }, 
        "_destroy"=>"false"}
    }, 
    "allergen_ids"=>["1", "2", "3", "4", "5", "6", "7", "8"]
  }
}

Recipe - ingredients_attributes= params:

{
  "1466598742270"=>{
    "amount"=>"1/2 pound", 
    "item_attributes"=>{
      "name"=>"Strawberry"
      }, 
    "_destroy"=>"false"},
  "1466598752602"=>{
    "amount"=>"4", 
    "item_attributes"=>{
      "name"=>"Kiwi"
      }, 
    "_destroy"=>"false"}
  }
}

search#allergen_search:

{
  "allergen_ids"=>["3", "4"]
}

Recipe - Recipe.match_allergens:

["3", "4"]
