import 'package:mega_civ_rules/models/paragraph.dart';

class Chapter {
  String title;
  List<Paragraph> paragraphs;

  Chapter(this.title, this.paragraphs);

  static List<Chapter> chapters() {
    return [
      new Chapter('Introduction', [
        Paragraph('Introduction', [
          ParagraphItem('''
            Mega Civilization is a game of skill for 5 to 18 players
            covering the historical development of ancient
            civilizations from just after the last Ice Age to the dawn
            of the new era at the end of the Iron Age - a time span of
            almost 8,000 years. Each player leads his own civilization
            as it tries to expand its culture over a map-board that
            stretches from the Mediterranean Sea to India.
          ''', []),
          ParagraphItem('''
          Although battles and territorial strategy are important,
            Mega Civilization is not a wargame as you might expect
            when looking at the map-board. Instead, the objective
            of play is to gain a level of overall advancement involving
            cultural, economic, scientific, political, civic and religious
            factors. The player who most effectively balances these
            various goals will achieve the best scores and win the
            game.
           ''', [])
        ]),
        Paragraph('The Goal', [
          ParagraphItem('''
          The objective of Mega Civilization is to acquire the
          highest number of Victory Points by building cities
          and developing Civilization Advances. This will be done
          over various phases and turns, some of which will be
          performed simultaneously by the players. After each
          turn, a check is made for each player to move forward
          on the Archaeological Succession Table (A.S.T.). Each step
          on this timeline represents a certain period of time in
          history reaching from the Stone Age. Advancement there
          will provide ever more Victory Points. The winner will
          not necessarily be the first player to reach the end of the
          A.S.T. or the player with the highest number of cities or
          Civilization Advances, although these are the key factors
          in determining the winner. 
          ''', [])
        ]),
        Paragraph('Description of play', [
          ParagraphItem('''
          Each civilization begins with a single population token
          and every turn each player increases his population by
          adding tokens to each area he occupies. These tokens
          can be moved over the map-board by land, or by sea
          using ships. As each area has a population limit, a
          good strategic overview will give players advantage in
          occupying more and more areas. If players manage
          to move sufficient tokens into areas they can build a
          city there. These cities generate trade cards which will
          eventually lead to knowledge and wealth.
          ''', []),
          ParagraphItem('''
          During trade sessions, players receive not only the
          commodities they need to complete sets; they might
          also receive calamities which will remove population
          or cities. Specific Civilization Advances will protect the
          players from natural or civic calamities. The development
          of these Civilization Advances is symbolized by turning
          in sets of trading goods, as the wealthier civilizations will
          acquire more Civilization Advances
          ''', []),
          ParagraphItem('''
          As civilizations develop, it will be harder for their rulers
          to find the right balance between future population
          growth, maintaining enough support for their cities and
          increasing their treasury. If they cannot manage their
          token population, their cities might eventually revolt
          during the Tax Collection-phase. The civilizations with the
          strongest economy traditionally score the highest.
          ''', [])
        ]),
        Paragraph('Length of a game', [
          ParagraphItem('''
          A game of Mega Civilization can take 10-12 hours
          to complete. Players can also choose to play the
          beginner-scenario ‘The First Game’, which will take only
          1-2 hours. Another scenario, ‘The Short Game’, provides
          the same excitement as the full game, although the game
          starts in a later age. This way games can be played in
          ‘just’ 6-8 hours
          ''', [])
        ]),
        Paragraph('Development', [
          ParagraphItem('''
          Somewhere around 1999 John Rodriguez, living in Texas,
          USA, picked up the idea to create a bigger map and some
          extra cards for his favorite game: Civilization by Francis
          Tresham. Much historical research ensued with larger
          and larger maps, new civilizations and new advances.
          A few years later, he shared his map and cards on the
          internet, creating the forum Civproject where anyone
          with ideas could contribute to his project.
          ''', []),
          ParagraphItem('''
          At the same time Flo de Haan, living in the Netherlands,
          Europe, had similar ideas creating extensions to
          his favorite game Civilization and started searching the
          internet for resources. He came across the forum and
          after a while John and Flo decided to work together to
          take this shared idea to a higher level. They worked on
          the design, artwork and simplicity to this enormous
          game which now accomodates up to 18 players. At first it
          was just an extension to the original game, but now they
          started working on the game from scratch. No single
          detail was safe. Rules would change radically, new ideas
          were launched and sometimes failed and years went
          by testing, testing, changing, testing, adding, removing,
          testing, changing and testing again. For years, each with
          their own group of players on either side of the ocean,
          John and Flo kept discussing their findings and fully
          redesigned the first idea to the game it is today. As each
          game takes a full day and requires a group of people
          to play, the effort to perform the most comprehensive
          testing was a real challenge.
          ''', []),
          ParagraphItem('''
          Here it is, Mega Civilization: a game for 5-18 players.
          Created by devoted Civilization-fans who put their heart
          into this wonderful game. We would like to thank: Gerart de Haan,
          Jon Severinsson, Martin Brodén, Jeffrey Brent McBeth,
          Judith van der Molen, Miquel Schumacher, Michael
          Bruinsma, Jacob Boersma, Jochem van Dijk, Mirjam
          Molenkamp, David van Nederveen Meerkerk, Johannes
          van der Horst, Bob Feis, Ronald Engeringh, Mike Droog,
          Marcel Remijn, Tony Lemmers, Rico Radeke, Nathan
          Barhorst, Bill Kohler and all the play-testers and the
          contributors of the Civproject forum.
          ''', [])
        ])
      ]),
      new Chapter('Game components', [
        Paragraph('Game components', [
          ParagraphItem('''
        TODO
        ''', [])
        ])
      ]),
      new Chapter('General rules and definitions', [
        Paragraph('The playing pieces', []),
        Paragraph('Barbarians and Pirates', [
          ParagraphItem('''
          As the game evolves, eventually barbarian tokens and
          pirate cities will appear on the board as a result of
          calamities.
          ''', [])
        ]),
        Paragraph('Units', [
          ParagraphItem('''
          Population tokens and cities are further referred to as
          ‘Units’. A population token counts as 1 unit point. A city
          counts as 5 unit points (or 5 units). Ships do not count
          as units.
          ''', [])
        ]),
        Paragraph('The player mats', [
          ParagraphItem('''
          Each player uses a player mat to store his playing pieces.
          The player mat is divided into two parts: treasury and
          stock, divided by the ‘sequence of play’. During the game
          it is important to note in which areas of the mat tokens
          will be kept. A player has 55 population tokens,
          9 cities and 4 ships. The 55 tokens are two-sided: one side
          serves as population, while the other serves as treasury.
          So each of his 55 tokens is either on the board, in stock or
          in treasury. Ships and cities are either on the board or in
          stock, but never in treasury.
          ''', [])
        ]),
        Paragraph('Stock', [
          ParagraphItem('''
          By default, each player’s playing pieces are placed in the
          stock-area with the colored side up and are considered
          to be ‘in stock’. If a playing piece is destroyed or removed
          from the board, it is returned to stock. If a player pays
          treasury, the treasury tokens are turned over and moved
          to stock. Tokens that are placed on the board are always
          taken from stock and, unless clearly specified, placed with
          the colored side up.
          ''', [])
        ]),
        Paragraph('Treasury', [
          ParagraphItem('''
          Some rules force or allow players to transfer tokens to
          the treasury-area. These tokens are then referred to as
          ‘treasury tokens’ or ‘in treasury’. Any tokens in treasury
          must be flipped upside down to show the white side. The
          amphorae are the symbol for a player’s treasury. Tokens
          in treasury are not regarded as population tokens.
          ''', [])
        ]),
        Paragraph('Map-board definitions', [
          ParagraphItem('''
          TODO:
          ''', [])
        ]),
        Paragraph('Civilization Advances', [
          ParagraphItem('''
          TODO
          ''', [])
        ]),
        Paragraph('Groups / colors', [
          ParagraphItem('''
          The cards are divided in 5 groups represented by colors
          as well as symbols: Science (green star), Arts (blue harp),
          Crafts (orange vase), Civics (red temple) and Religion
          (yellow tribal). Some Civilization Advances belong to 2
          groups rather than just 1.
          ''', [])
        ]),
        Paragraph('Victory points', [
          ParagraphItem('''
          On the right top side of each card, it shows either 1, 3
          or 6 Victory Points in a banner symbol. The points are
          counted at the end of the game to determine the winner.
          ''', [])
        ]),
        Paragraph('Attributes', [
          ParagraphItem('''
          Most Civilization Advances show one or more attributes
          that apply to the holder of the card exclusively.
          These attributes typically provide calamity protection
          or benefits in play, however, sometimes they might
          aggravate certain calamity effects in addition to these
          benefits. Special Abilities can be used once a turn during
          a specific phase called Special Abilities-phase.
          ''', [])
        ]),
        Paragraph('Credits and credit symbols', [
          ParagraphItem('''
          Once a player acquires a Civilization Advance, he receives
          the credit tokens printed on the left side of the card.
          These credits give a bonus when purchasing other Civilization
          Advances of the same group. Some Civilization
          Advances provide additional credit tokens marked with a
          ; these credits are then mentioned in the attributes. A
          majority of the Civilization Advances provide additional
          credits to a specific card.
          ''', [])
        ]),
        Paragraph('Trade cards', [
          ParagraphItem('''
          It is important to keep a division between ‘blue marked’
          cards and ‘orange marked’ cards (blue and orange cards
          have different backsides). Orange marked cards are only
          used in games of 12-18 players.
          The trade cards are divided in 2 groups: ‘Commodities’
          and ‘Calamities’.
          • Commodities show trading goods.
          • Calamities show an illustration and either the
          indication ‘Minor Calamity’, ‘Major Calamity’ or
          ‘Major Calamity (Non Tradeable)’.
          ''', [])
        ]),
        Paragraph('Archeological Succession Table (A.S.T.)', [
          ParagraphItem('''
          The Archaeological Succession Table (further called A.S.T.)
          has two sides. One side shows the ‘Basic A.S.T.’, the other
          side is the ‘Expert A.S.T.’ for experienced players. We
          suggest to start your first games using the ‘Basic A.S.T.’.
          The A.S.T. is divided into 6 epochs: Stone age, Early Bronze
          Age, Middle Bronze Age, Late Bronze Age, Early Iron Age
          and Late Iron Age. Players start placing their succession
          marker covering the arrow on the left and after each
          turn, if players meet the requirements mentioned on
          top, they may move their succession marker 1 space to
          the right. These rows vary per player and each civilization
          must stick to his own requirements per step on the A.S.T.
          ''', [])
        ]),
        Paragraph('A.S.T.-ranking / A.S.T.-position', [
          ParagraphItem('''
           ‘A.S.T.-ranking’ or ‘A.S.T.-order’ is specified as
            the vertical position on the list of civilizations
            as printed on the A.S.T., from the top to the
            bottom, irrespective of the horizontal position of
            succession markers. Smaller Civilization numbers
            take priority over larger Civilization numbers.
            • ‘A.S.T.-position’ is specified as the horizontal
            position of the actual succession markers. The
            marker furthest to the right is considered to be
            highest in position order. Ties are broken by
            A.S.T.-ranking order.
            Whenever ‘A.S.T.-order’ is mentioned this refers to ‘A.S.T.-
            ranking’ order.
            At any time, if a tie occurs between players’ activities
            and it is not clearly specified how to break the tie, it is
            resolved in A.S.T.-ranking order.
            A turn marker is used to show the number of turns
            played.
          ''', [])
        ]),
      ]),
      new Chapter('Setting up the game', [
        Paragraph('TODO', [
          ParagraphItem('''
      TODO
          ''', [])
        ])
      ]),
      new Chapter('Map-board setups', [
        Paragraph('TODO', [
          ParagraphItem('''
      TODO
          ''', [])
        ])
      ]),
      new Chapter('Sequence of play', [
        Paragraph('TODO', [
          ParagraphItem('''
      TODO
          ''', [])
        ])
      ]),
      new Chapter('Leaving the game', [
        Paragraph('TODO', [
          ParagraphItem('''
      TODO
          ''', [])
        ])
      ]),
      new Chapter('Card specific rules - The Calamities', [
        Paragraph('TODO', [
          ParagraphItem('''
      TODO
          ''', [])
        ])
      ]),
      new Chapter('Card specific rules - The Advances', [
        Paragraph('TODO', [
          ParagraphItem('''
      TODO
          ''', [])
        ])
      ]),
      new Chapter('The Short Game', [
        Paragraph('TODO', [
          ParagraphItem('''
      TODO
          ''', [])
        ])
      ]),
      new Chapter('Division of Trade Cards', [
        Paragraph('TODO', [
          ParagraphItem('''
      TODO
          ''', [])
        ])
      ]),
    ];
  }
}
