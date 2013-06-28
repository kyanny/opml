require 'spec_helper'
require 'opml'

shared_examples "a sample OPML file" do

  it "should have the owner of the document" do
    @opml.owner_name.should == "Dave Winer"
  end

  it "should have the email address of the owner of the document" do
    @opml.owner_email.should == "dave@userland.com"
  end

end

shared_examples "an empty OPML file" do

  it "should have no title" do
    @opml.title.should be_nil
  end

  it "should have no outlines" do
    @opml.outlines.size.should == 0
  end

end


describe Opml, "playlist" do

  before do
    text = File.read(File.dirname(__FILE__) + "/files/playlist.opml")
    @opml = Opml.new(text)
  end

  it_should_behave_like "a sample OPML file"

  it "should have a title of the document" do
    @opml.title.should == "playlist.xml"
  end

  it "should have a date-time, indicating when the document was created" do
    @opml.date_created.should == Time.parse("Thu, 27 Jul 2000 03:24:18 GMT")
  end

  it "should have a date-time, indicating when the document was last modified" do
    @opml.date_modified.should == Time.parse("Fri, 15 Sep 2000 09:01:23 GMT")
  end

  it "should have outlines" do
    @opml.outlines.size.should == 3
    @opml.outlines[0].outlines.size.should == 1
    @opml.outlines[1].outlines.size.should == 13
    @opml.outlines[2].outlines.size.should == 7
  end

  it "should return flattened outlines" do
    @opml.flatten.size.should == 24
  end

end

describe Opml, "presentation" do

  before do
    text = File.read(File.dirname(__FILE__) + "/files/presentation.opml")
    @opml = Opml.new(text)
  end

  it_should_behave_like "a sample OPML file"

  it "should have a title of the document" do
    @opml.title.should == "presentation.xml"
  end

  it "should have a date-time, indicating when the document was created" do
    @opml.date_created.should == Time.parse("Thu, 27 Jul 2000 01:35:52 GMT")
  end

  it "should have a date-time, indicating when the document was last modified" do
    @opml.date_modified.should == Time.parse("Fri, 15 Sep 2000 09:05:37 GMT")
  end

  it "should have outlines" do
    @opml.outlines.size.should == 17
    @opml.outlines[0].outlines.size.should == 2
    @opml.outlines[1].outlines.size.should == 5
    @opml.outlines[2].outlines.size.should == 4
  end

  it "should return flattened outlines" do
    @opml.flatten.size.should == 91
  end

end

describe Opml, "specification" do

  before do
    text = File.read(File.dirname(__FILE__) + "/files/specification.opml")
    @opml = Opml.new(text)
  end

  it_should_behave_like "a sample OPML file"

  it "should have a title of the document" do
    @opml.title.should == "specification.xml"
  end

  it "should have a date-time, indicating when the document was created" do
    @opml.date_created.should == Time.parse("Thu, 27 Jul 2000 01:20:06 GMT")
  end

  it "should have a date-time, indicating when the document was last modified" do
    @opml.date_modified.should == Time.parse("Fri, 15 Sep 2000 09:04:03 GMT")
  end

  it "should have outlines" do
    @opml.outlines.size.should == 4
    @opml.outlines[0].outlines.size.should == 4
    @opml.outlines[1].outlines.size.should == 4
    @opml.outlines[2].outlines.size.should == 4
  end

  it "should return flattened outlines" do
    @opml.flatten.size.should == 17
  end

end

describe Opml, "empty body" do

  before do
    @opml = Opml.new("<opml><body></body></opml>")
  end

  it_should_behave_like "an empty OPML file"

end

describe Opml, "empty outline" do

  before do
    @opml = Opml.new("<opml></opml>")
  end

  it_should_behave_like "an empty OPML file"

end

describe Opml, "empty file" do

  before do
    @opml = Opml.new("")
  end

  it_should_behave_like "an empty OPML file"

end

describe Opml, "incorrect date" do

  before do
    @opml = Opml.new("<opml><head><dateCreated>1372185524793</dateCreated></head><body></body></opml>")
  end

  it_should_behave_like "an empty OPML file"

end

describe Opml::Outline, "in playlist" do

  before do
    text = File.read(File.dirname(__FILE__) + "/files/playlist.opml")
    @outline = Opml.new(text).outlines[1]
  end

  it "should return all attributes" do
    @outline.attributes.should == {"text" => "The Last Napster Sunday?"}
  end

  it "should return text attribute" do
    @outline.text.should == "The Last Napster Sunday?"
  end

  it "should respond to text attribute" do
    @outline.respond_to?(:text).should be_true
  end

  it "should return text when coerce into a string" do
    @outline.to_s.should == "The Last Napster Sunday?"
  end

  it "should return flattened child outlines" do
    @outline.flatten.map(&:to_s).should == [
      "The Last Napster Sunday?", 
      "Heart of Glass.mp3", 
      "Manic Monday.mp3", 
      "Everybody Have Fun Tonight.mp3", 
      "She Blinded Me With Science.mp3", 
      "Rivers of Babylon   (HTC).mp3", 
      "The Tide Is High.mp3", 
      "Back to the Island.mp3", 
      "Lucky Man.mp3", 
      "Up on Cripple Creek.mp3", 
      "Crackerbox Palace.mp3", 
      "Taxi.Mp3", 
      "Thick As A Brick.mp3", 
      "Riding With the King.mp3"
    ]
  end

end
