require('vendor/spine')
require('vendor/spine/parse')

class Contact extends Spine.Model

  @configure 'Contact', 'first_name', 'last_name'

  @extend Spine.Model.Parse


c = Contact.create first_name: 'Bob', last_name: 'Wiley'

