#
#  GEGist.rb
#  gisteditor
#
#  Created by Greg Borenstein on 6/6/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

class GEGist
  attr_accessor :gist_id, :created_at

  def self.new_from_xml(xml)
    self.new :gist_id => self.extract_from_xml(xml, 'repo'),
             :created_at => self.extract_from_xml(xml, 'created-at')
  end
  
  def self.extract_from_xml(xml, value)
    NSLog(value)
    xml.rootElement.nodesForXPath("gist/#{value}", error:nil).first.stringValue
  end
  
  def initialize(opts={})
    @gist_id = opts[:gist_id]
    @created_at = opts[:created_at]
  end
  
  def to_h
    {:gist_id => @gist_id,
     :created_at => @created_at}
  end
  
  def save(owner)
    NSLog("owner: #{owner.inspect}")
    owner.library['gists'] << self.to_h
    owner.flushLibrary
  end
end