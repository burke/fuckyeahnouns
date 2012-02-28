module Spice

  extend self

  def up(noun)
    seed = case rand(11)
    when 0..4  then RANDOM
    when 5..6  then MEMES
    else
      CELEBS
    end

    case rand(11)
    when 1  then random(seed)
    when 2  then prefix(noun,seed)
    when 3..7 then noun
    else
      suffix(noun,seed)
    end
  end

  def random(collection)
    collection.shuffle.first
  end

  def replace(noun,collection)
    random(collection)
  end

  def prefix(noun,collection)
    random(collection) << " " << noun
  end

  def suffix(noun,collection)
    noun << " " << random(collection)
  end

  RANDOM = [
    'boobs',
    'sexy',
    'wicked',
    'hot',
    'hotest',
    'sex',
    '18',
    '21',
    'cute'
  ]

  MEMES  = [
    "Blendtec",
    "Cooks Source infringement controversy",
    "FreeCreditReport.com",
    "Embrace Life",
    "HeadOn",
    "Lowermybills.com",
    "Shake Weight",
    "The Man Your Man Could Smell Like",
    "Young Darth Vader",
    "JibJab",
    "Caramelldansen",
    "Charlie the Unicorn",
    "Dancing baby",
    "Happy Tree Friends",
    "Homestar Runner",
    "Joe Cartoon",
    "Loituma Girl",
    "Leekspin",
    "My Little Pony",
    "Friendship Is Magic",
    "Salad Fingers",
    "This Land is Your Land",
    "Ultimate Showdown of Ultimate Destiny",
    "Weebl and Bob",
    "Goodtimes virus",
    "The Blair Witch Project",
    "Brokeback Mountain",
    "Cloverfield",
    "Mega Shark Versus Giant Octopus",
    "Party Gir",
    "Snakes on a Plane",
    "All Your Base",
    "All your base are belong to us",
    "Giant Enemy Crab",
    "Leeroy Jenkins",
    "Line Rider",
    "I Love Bees",
    "Tron Guy",
    "Ate my balls",
    "Allison Stokke",
    "Baidu 10 Mythical Creatures",
    "Bert is Evil",
    "Cigar guy",
    "Crasher Squirrel",
    "Goatse.cx",
    "Heineken Looter Guy",
    "A LOLcat",
    "Islamic Rage Boy",
    "Kermit Bale",
    "Little Fatty",
    "LOLcat",
    "O RLY?",
    "Oolong",
    "The Saugeen Stripper",
    "Seriously McDonalds",
    "Tron Guy",
    "Vancouver Riot Kiss",
    "Rosines Chavez",
    "Gary Brolsma",
    "The Numa Numa Guy",
    "Average Homeboy",
    "Dancing Banana",
    "Canon Rock",
    "Chocolate Rain",
    "Dear Sister",
    "Ekrem Jevric",
    "Friday",
    "Hampster Dance",
    "Hurra Torpedo",
    "JK Wedding Entrance Dance",
    "Literal music video",
    "Little Superstar",
    "Lucian Piane, aka RevoLucian",
    "The Muppets: Bohemian Rhapsody",
    "McDonald's rap",
    "Numa Numa",
    "OK Go music videos",
    "Pants on the Ground",
    "Red Solo Cup",
    "Take U to da Movies",
    "Techno Viking",
    "Prison Thriller",
    "Trololo",
    "Twelve Days of Christmas",
    "United Breaks Guitars",
    "We Gon Rock",
    "Freecycling",
    "One red paperclip",
    "Secret London",
    "Three Wolf Moon",
    "2 Girls 1 Cup",
    "The Annoying Orange",
    "Ask a Ninja",
    "Badger Badger Badger",
    "Benny Lava",
    "Bed Intruder Song",
    "Boom goes the dynamite",
    "Charlie Bit My Finger",
    "Charlie Chaplin Time Travel Video",
    "The Crazy Nastyass Honey Badger",
    "Dancing Matt",
    "Diet Coke and Mentos",
    "Double Rainbow",
    "Don't Tase Me, Bro!",
    "Downfall Parodies",
    "Dramatic Chipmunk",
    "Edgar's fall",
    "eHarmony Video Bio",
    "Epic Beard Man",
    "Fenton",
    "Fred Figglehorn",
    "Heroine of Hackney",
    "I Like Turtles",
    "Impossible Is Nothing",
    "Jag har mensvark",
    "Ken Lee",
    "Kersal Massive",
    "Keyboard Cat",
    "The Last Lecture",
    "League of Ireland fan",
    "Leave Britney Alone!",
    "Lonelygirl15",
    "Maru the cat",
    "Melissa Theuriau",
    "Nek Minnit",
    "Nyan Cat",
    "Obama Girl",
    "Rickrolling",
    "Shreds",
    "Star Wars Kid",
    "Tyson",
    "UFO Phil",
    "What What (In the Butt)",
    "Wii Fit Girl",
    "Winnebago Man",
    "Youtube Poop",
    "Zangief Kid",
    "Other",
    "Creepypasta",
    "Figwit",
    "Illegal flower tribute",
    "Vuvuzelas",
    "Zombie Jesus",
  ]

  CELEBS = [
    'Katy Perry',
    'Tammin Sursok',
    'Evan Rachel Wood',
    'Laura Vandervoort',
    'kim kardashian',
    'Eva Mendes',
    'Leighton Meester',
    'Lauren Conrad',
    'Adrianne Palicki',
    'Julianne Hough',
    'Emily Van Camp',
    'Blake Lively',
    'Kristen Kreuk',
    'Kaley Cuoco',
    'Katharine McPhee',
    'Gemma Arteron',
    'Keira Knightley',
    'Michelle Trachtenberg',
    'Ashlee Simpson-Wentz',
    'Emma Roberts',
    'Sarah Wright',
    'Amanda Bynes',
    'Colbie Calliat',
    'Maria Sharapova',
    'Elisha Cuthbert',
    'Aimee Teegarden',
    'Kendra Wilksinon',
    'Karissa and Kristina Shannon',
    'Adrienne Bailon',
    'Lindsay Lohan',
    'Maggie Grace',
    'Lyndsy Fonseca',
    'Emma Stone',
    'Rihanna',
    'Vanessa Hudgens',
    'Ashley Tisdale',
    'Hayden Panettiere',
    'Audrina Patridge',
    'Emma Watson',
    'Megan Fox',
    'Scarlett Johanssen',
    'Mila Kunis',
    'Jennifer Lopez'
  ]
end
