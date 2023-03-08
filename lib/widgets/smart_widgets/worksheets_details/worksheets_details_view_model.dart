import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/views/home/home_view.dart';

class WorksheetsDetailsViewModel extends FutureViewModel {
  //Basic services used
  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  Logger log;
  DateTime selectedDay = DateTime.now();
  String uid;
  Future futureForWorksheetModels;

  //Fields related to ABCDE Model
  TextEditingController abcdeModelInternal = new TextEditingController();
  TextEditingController abcdeModelExternal = new TextEditingController();
  TextEditingController abcdeModelAssumptions = new TextEditingController();
  TextEditingController abcdeModelFactual = new TextEditingController();
  TextEditingController abcdeModelBehavioral = new TextEditingController();
  TextEditingController abcdeModelEmotional = new TextEditingController();
  TextEditingController abcdeModelPhysiological = new TextEditingController();
  TextEditingController abcdeModelDisputation = new TextEditingController();
  TextEditingController abcdeModelEffect = new TextEditingController();
  List buildABCDEModelBoxes;
  String worksheetName;

  //Fields related to behavioral model
  int currentRank = 0;
  List buildBehavioralActivationModelBoxes = [
    {"rank": 9, "content": "Acceptance and focusing on priorities"},
    {"rank": 8, "content": "Showing support to those who are grieving"},
    {"rank": 7, "content": "Stay with family for a few days"},
    {"rank": 6, "content": "Get support"},
    {"rank": 5, "content": "Feeling low after losing a loved one"},
    {"rank": 4, "content": "Sitting at home alone"},
    {
      "rank": 3,
      "content": "Feeling responsible for not preventing this from happening"
    },
    {
      "rank": 2,
      "content":
          "Crying in bed for days not knowing whats going to happen to me without this person"
    },
    {"rank": 1, "content": "Feeling like there is no point to life"},
  ];

  //Fields related to basic worksheet
  TextEditingController worryingAbout = new TextEditingController();
  TextEditingController whatCanIDoAboutThis = new TextEditingController();
  bool yes = false;
  bool no = false;
  List whatCanIDo = [];
  List buildBasicModelBoxes;

  //Fields related to Social Activation Worksheet
  TextEditingController socialActivationPeopleToCall =
      new TextEditingController();
  TextEditingController socialActivationActivity = new TextEditingController();
  TextEditingController socialActivationSchedule = new TextEditingController();
  TextEditingController socialActivationActivityThought =
      new TextEditingController();
  TextEditingController socialActivationActivityReality =
      new TextEditingController();
  List buildSocialActivationModelBoxes;

  //Fields related to template 1

  //Topic 1 : 4 A's of Stress

  Map template1Topic1 = {
    "title": "4 A's of Stress",
    "subtitles": ["Avoid", "Alter", "Adapt", "Accept"],
    "answers": []
  };
  Map template1Topic2 = {
    "title": "Eisenhower's Time Management Matrix",
    "subtitles": [
      "Important & \nUrgent\n\nDO",
      "Important & \nNot Urgent\n\nMAKE TIME",
      "Not Important & \nUrgent\n\nDELEGATE",
      "Not Important & \nNot Urgent\n\nELIMINATE"
    ],
    "answers": [],
  };
  //Fields related to template 2
  Map template2Topic1 = {
    "title": "Turning Stress Into Action",
    "summary": "Did you know that the symptoms we feel when we’re stressed and those that we feel when we’re excited are exactly the same? You may have noticed how you feel your heart racing, you begin to sweat, or this tightness in your stomach before going on a rollercoaster ride? That’s the same way we feel when something stressed us out. So let's see how we can use our stress to propel us into action! How can you use this energy to rise to the occasion ?",
    "questions" : [
      "What is stressing you out?",
      "How does this affect your...",
      "Now think of these emotion as a rush of energy that helps you rise to the ocassion and take action",
      "What would you do to take back control?",
      "How would this change your...",
    ],
    "multiple_answers": [true, false, false, true, false],
    "hints": [
      [
        "Ex. Work, career, Family, Health, Friendships etc.",
      ],
      ["Thoughts", "Emotions", "Bodily changes", "Behaviour"],
      [],
      [],
      ["Thoughts", "Emotions", "Bodily changes", "Behaviour"]
    ],
    "answers": [],
  };
  Map template2Topic2 = {
    "title": "Rule of three",
    "summary":"A great way to tackle our to-do list so we can breathe a sigh of relief at the end of it is by focusing on 3 concrete things for the day. The first step is to simply write down everything we need to do. You don’t have to feel overwhelmed by the list. Just try to complete the 3 most important things in there. Remember to acknowledge when you’ve completed a task. The dopamine released brings a sense of accomplishment, happiness and motivates us to keep going!",
  "questions": [
      "Write down everything you need to do today ",
      "What are your 3 main tasks that would bring about the most releif after completion?",
      "How do you plan on allocating your time to these three tasks?",
      "How can you break each task into clear steps?",
      "Is there anyone you can ask for help?",
      "How would you feel after taking completing these three tasks"
    ],
    "multiple_answers": [true, false, true, true, false, true],
    "hints": [
      [
        "Ex. laundry, housework, submitting an assignment, preparing for an interview, exercise, cook",
      ],
      ["Task 1", "Task 2", "Task 3"],
      [],
      [],
      ["Ex. friend, collegue, mentor, sibling"],
      ["Ex. energised, fulfilled, good, happy, motivated, calm, relaxed"]
    ],
    "answers": []
  };
  Map template2Topic3 = {
    "title": "Stop worrying about the future",
    "summary":"We worry about things that may or may not happen in the future. While it may be productive to anticipate future outcomes and take necessary caution, most of the time our worries aren't action-oriented or solution-focused. They’re just a cycle of unhelpful thoughts, leaving us drained or stressed out. Let's see how we can beat this habit by taking action or simply letting go of things beyond our control.",
  "questions": [
      "What are you worrying about?",
      "What do your worries sound like?",
      "How do these worries affect your...",
      "What is your desired outcome/ What do you want from this situation?",
      "Is there something you can do about it?",
      "",
      "How do you feel now?"
    ],
    "multiple_answers": [true, true, false, true, false, false, true],
    "hints": [
      [
        "Ex. diet, health, finances, life, college, assignments, exams, my abilities, my family, my partner, my kids",
      ],
      [
        "What if...",
        "I feel...",
        "What do I do about...",
        "I'm afraid that...",
        "I will never be..."
      ],
      ["Thoughts", "Emotions", "Bodily changes", "Behaviour"],
      [],
      [],
      [
        "Ex. I can ask for help, I can apologize, I can have a conversation, I can make use of my time, money, skills, energy"
      ],
      [
        "Ex. I feel lighter, more empowered, more confident, more present, more prepared, happier, relieved, calm, still feel the same"
      ]
    ],
    "answers": []
  };
  bool template2Topic3Yes, template2Topic3No;

  //Fields related to template 3

  //Topic 1 : Reframing our "should" statements
  bool template3Topic1Yes = false;
  bool template3Topic1No = false;
  Map template3Topic1 = {
    "title": "Reframing our SHOULD statements",
    "summary":"We often assume things “Should” be a certain way – We should be able to handle problems on our own, our kids should be good at math etc. And when don’t keep up with our should statements, we often feel disheartened or frustrated, and feel even more hopeless. However, we can change this by accepting the reality of our situation and asking ourselves how we CAN do our best given the current circumstances.",
    "questions": [
      "What are some of your SHOULD statements?",
      "Why do you think things SHOULD be this way?",
      "How do these statements make you feel?",
      "Are your SHOULD statements 100% realistic?",
      "How can you rephrase your should statement with more kindness, given the current circumstances? What COULD you do going forward?",
      "How do your new statements make you feel?"
    ],
    "multiple_answers": [true, true, false, false, true, true],
    "hints": [
      [
        "Ex. I should be working out everyday",
        "Ex. I should be treated better",
        "Ex. My kid should be able to handle his homework"
      ],
      [
        "Ex. Everyone else is able to do it",
        "Ex. Its the rule I have set for myself",
        "Ex. It is what is expected of me"
      ],
      [
        "Ex. I feel guilty",
        "Ex. I feel angry",
        "Ex. I feel frustrated",
        "Ex. I feel sad",
        "Ex. I feel hopeless",
        "Ex. I feel anxious",
        "Ex. I feel stressed",
        "Ex. I feel worthless",
      ],
      [],
      [
        "Ex. I could forget the past and focus on the present",
        "Ex. I could prioritise my mental well being",
        "Ex. I could find an alternative solution to my problems",
      ],
      [
        "Ex. I feel lighter",
        "Ex. I can ask for help",
        "Ex. I feel more empowered",
        "Ex. My should statements don't define me",
        "Ex. I feel more confident",
        "Ex. I feel more accepting of reality",
      ]
    ],
    "answers": [],
  };
  //Topic 2 : What's stopping you from taking a break
  Map template3Topic2 = {
    "title": "What's stopping you from taking a break",
    "summary":
        "Some of us get so used to working that even when it’s time to relax we feel this uneasiness – As if it’s a sign of laziness, or that we’re not living to our full potential. But research has shown that taking healthy breaks can help energize ourselves and boost our productivity.",
    "questions": [
      "How do you feel when you are taking a break? ",
      "What are some of your thoughts? ",
      "What can you tell yourself when you feel guilty for taking breaks?",
      "How can you make the best use of this free time to recharge or relax?",
      "How would you feel after taking this break?",
      "When and how much time would you set aside for this? (during or after work)"
    ],
    "multiple_answers": [true, true, true, true, true, false],
    "hints": [
      [
        "Ex. I feel guilty",
        "Ex. I feel happy",
        "Ex. I feel calm",
        "Ex. I feel complete",
        "Ex. I feel fulfilled",
        "Ex. I feel nervous",
        "Ex. I feel ashamed",
      ],
      [
        "Ex. I feel guilty",
        "Ex. I feel sad",
        "Ex. I feel like I'm rewarding myself",
        "Ex. I feel nervous",
        "Ex. I feel anxious",
        "Ex. I feel stressed",
        "Ex. I feel worthless",
      ],
      [
        "Ex. I'm allowed to reward myself for hardwork",
        "Ex. I feel more motivated to work instead of burning out",
        "Ex. Taking a break is necessary",
        "Ex. There are other parts of my life that are more important or just as important as work",
        "Ex. I can work better knowing I have something to look forward to afterward",
        "Ex. Working all the time isn't what life is all about",
        "Ex. I feel stressed",
        "Ex. I feel worthless",
      ],
      [
        "Ex. Music",
        "Ex. Exercise",
        "Ex. Playing with my kids",
        "Ex. Spending time with my partner",
        "Ex. Spending time with my parents",
        "Ex. Playing a sport",
        "Ex. Reading",
        "Ex. Sleeping"
      ],
      [
        "Ex. Energised",
        "Ex. Fulfilled",
        "Ex. Good",
        "Ex. Happy",
        "Ex. Motivated",
        "Ex. Calm",
        "Ex. Relaxed"
      ],
      ["Ex. 1 hr"]
    ],
    "answers": [],
  };
  //Topic 3 : Less is more
  Map template3Topic3 = {
    "title": "Less is More",
    "summary":
        "Our default way of solving a problem is by adding. This is why we end up over doing so much. You may have seen this while writing a report, we end up writing more instead of editing out the unnecessary parts. Or we may decide to work out twice as hard, although the easier solution is to eat lesser junk food. Let's see how we can use this approach to your life:",
    "questions": [
      "What is the problem you are trying to solve?",
      "What is the outcome you desire?",
      "What is your course of action?",
      "How can you resolve or simplify this problem by REMOVING any unnecessary parts?",
      "Is there anyone you can ask for help?",
      "What could be a new approach to arrive at the same solution?"
    ],
    "multiple_answers": [true, true, true, true, false, true],
    "hints": [
      [
        "Ex. Work on my diet",
        "Ex. Improve my health",
        "Ex. Complete an assignment",
        "Ex. Set out my priorities",
        "Ex. Manage my finances",
        "Ex. Improve my relationships"
      ],
      [],
      [],
      [
        "Ex. Reducing social media",
        "Ex. Avoiding toxic people",
        "Ex. Eliminating what's not important",
        "Ex. Reducing my expenditure",
        "Ex. Eating less junk",
        "Ex. Quit smoking",
        "Ex. Prevent lashing out"
      ],
      ["Ex. friend, collegue, mentor, sibling"],
      [
        "Ex. Feel more motivated",
      ]
    ],
    "answers": [],
  };
  //Topic 4 : Questioning Our Assumptions
  Map template3Topic4 = {
    "title": "Questioning Our Assumptions",
    "summary":
        "When we worry too much, we may imagine danger waiting in every corner, even if we don’t have complete evidence to confirm our worrying thoughts! Have you noticed your mind doing this?\nConstantly worrying about what might happen can lead to chronic stress. If you find yourself worrying excessively, take a few deep breaths and answer the following questions to take back control!",
    "questions": [
      "What are you worrying about?",
      "What worst case scenario/ scenarios you think might happen?",
      "Is this worry based on facts or assumptions? (Take a few deep breaths before answering this one)",
      "Is there anything you can do to reduce the likelihood of it?",
      "If this does take place, what are the consequences?",
      "How do you see yourself coping if this does end up happening?",
      "Is there anyone you can ask for help?",
      "What would be your plan of action?"
    ],
    "multiple_answers": [true, true, true, true, true, true, false, true],
    "hints": [
      ["Ex. Health, finances, family, my relationships"],
      [
        "Ex. I may end up broke",
        "Ex. My partner may leave me",
        "Ex. I may lose a loved one"
      ],
      [],
      [],
      [],
      [],
      ["Ex. friend, collegue, mentor, sibling"],
      []
    ],
    "answers": [],
  };
  //Topic 5 : Tapping into our Resources
  Map template3Topic5 = {
    "title": "Tapping into our Resources",
    "summary":"Our worrying thoughts can cloud our thinking, and make us feel like there's no way we’ll be able to cope with our situation. But this is because we often overlook the resources we have at our disposal. If you look closely you’ll realise that there is more than one solution to your problem. Take a few deep breaths and try to fill out the following questions to help you deal with a potential stressor with more confidence. ",
    "questions": [
      "What are you worrying about?",
      "What worst case scenario/ scenarios you think might happen?",
      "What are some of your own skills and abilities you can use to cope with the stressor?",
      "Who are the people around you that you can ask for help?",
      "What are some of the other resources you can utilise?",
      "Having taken a closer look at the resources available to you, how do you to plan on coping with your present worry?"
    ],
    "multiple_answers": [true, true, true, false, true, true],
    "hints": [
      ["Ex. Health, finances, family, my relationships, work"],
      [
        "Ex. I may end up broke",
        "Ex. I may lose my job",
        "Ex. My partner may leave me",
        "Ex. I may fail a test",
        "Ex. I may lose a loved one",
        "Ex. I may disappoint a family member"
      ],
      ["Ex. hardwork, knowledge, age, health, communication skills, network"],
      [
        "Ex. parent, sibling, mentor,  guide, therapist, friend, collegue, boss"
      ],
      [
        "Ex. time, money, information",
      ],
      []
    ],
    "answers": [],
  };
  //Topic 6 : Thought Record
  bool template3Topic6Yes = false;
  bool template3Topic6No = false;
  Map template3Topic6 = {
    "title": "Thought Record",
    "summary":
      "Research shows that we have around 70,000 thoughts per day. And many of these thoughts incite feelings of self-doubt, fear, and discouragement. Here are a few questions you can ask yourself to balance your negative thinking… With practice, you can train your brain to develop healthier thoughts and behaviours",
    "questions": [
      "Situation • Describe the situation that led to your negative feelings",
      "Initial Thought • What thought first crossed your mind?",
      "Challenge your initial thought • How successful has this thinking been for you in the past? What facts do you have that support or challenge your initial thought? What strengths do you have that you may have overlooked?\nWhat advice would you give someone else in the same situation?",
      "Alternative thinking • How can you handle the situation differently? Drop any negative assumptions, and think of possibilities or facts that you may have overlooked.",
      "Positive belief and affirmation • Write down an affirmation, that reflects a healthier approach. Choose something that you can use as a reminder.",
      "Action plan • What can you do if this situation arises again? Write a list of strengths you bring to the situation? What can you do if you fall back on old habits?",
      "Improvement • Do you feel slightly better or more optimistic?"
    ],
    "multiple_answers": [false, false, true, true, true, true, false],
    "hints": [[], [], [], [], [], [], []],
    "answers": [],
  };
  //Topic 7 : Tiny changes with big benefits
  Map template3Topic7 = {
    "title": "Tiny changes with big benefits",
    "summary":
    "Have you ever noticed how small tiny things in your life make all the difference? It could be being 5 mins early to work that lifts a ton of stress. Or a simple act of kindness that helps you feel so positive. Maybe it's just doing your bed or setting aside 10 minutes to meditate/ or exercise daily, which helps you power through your day with so much more clarity and energy. These acts usually seem small and insignificant and therefore we neglect them but they make a big difference in our lives because of the incremental benefits that follow. Let's reflect on this for a  moment",
    "questions": [
      "What is one small act that you can do that would help you bring down a significant amount of stress?",
      "How much effort do you think it would take?",
      "Think of the additional benefits that come through this simple activity?",
    ],
    "multiple_answers": [true, false, true],
    "hints": [
      [
        "Ex. Being more understanding",
        "Ex. Meditating for 10 mins",
        "Ex. Exercising for 20 mins",
        "Ex. Eating healthy",
        "Ex. Expressing yourself"
      ],
      [],
      [
        "Ex. Increased focus",
        "Ex. Healthier Relationships",
        "Ex. Increased calmness",
        "Ex. Reduces stress",
        "Ex. Lesser burdens",
        "Ex. Healthier mind",
        "Ex. happier, healthier, fitter, positive, more in control",
      ],
    ],
    "answers": [],
  };
  //Topic 8 : Habits
  Map template3Topic8 = {
    "title": "Habits",
    "summary":
        "We might have some habits which would be indirectly adding to our stress. On the other hand, cultivating few good habits can help us handle stress better. Take a moment to list some of your habits below",
    "questions": [
      "What are some of your habits that may be adding to your stress?",
      "How do you think this is worsening your life?",
      "What are the steps that you could take to reduce/cut-out these habits?",
      "What's a simple habit that you could develop?",
      "How would this reduce your stress?",
      "What's one step you could take to develop this habit?"
    ],
    "multiple_answers": [true, true, true, false, false, false],
    "hints": [
      [
        "Ex. Smoking, binge eating, binge drinking, excessive social media, excessive caffiene"
      ],
      [
        "Ex. hurts my relationships, adds to my stress, worsens my health, reduces my focus"
      ],
      [],
      [
        "Ex. practising a skill",
        "Ex. mindfull eating",
        "Ex. limit drinking",
        "Ex. limit social media",
        "Ex. cut down smoking",
        "Ex. exercising"
      ],
      [
        "Ex. increased focus",
        "Ex. healthier relationships",
        "Ex. increased calmness",
        "Ex. reduces stress",
        "Ex. lesser burdens",
        "Ex. healthier mind",
        "Ex. happier, healthier, fitter, positive, more in control"
      ],
      []
    ],
    "answers": [],
  };
  // Fields related to Template 4
  //Topic 1 : Living a life of meaning and purpose
  Map template4Topic1 = {};
  String template4Topic1Answer1a;
  String template4Topic1Answer1b;
  String template4Topic1Answer1c;
  String template4Topic1Answer2a;
  String template4Topic1Answer2b;
  String template4Topic1Answer2c;
  String template4Topic1Answer3a;
  String template4Topic1Answer3b;
  String template4Topic1Answer3c;
  String template4Topic1Answer4a;
  String template4Topic1Answer4b;
  String template4Topic1Answer4c;
  String template4Topic1Answer5a;
  String template4Topic1Answer5b;
  String template4Topic1Answer5c;
  String template4Topic2Answer1a;
  String template4Topic2Answer1b;
  String template4Topic2Answer1c;
  String template4Topic2Answer2a;
  String template4Topic2Answer3a;
  List<String> template4Topic1Question1Strings = [
    "Commitment",
    "Authenticity",
    "Compassion",
    "Concern for others",
    "Consistency",
    "Courage",
    "Dependability",
    "Fearlessness",
    "Friendliness",
    "Good humour",
    "Honesty",
    "Honour",
    "Independence",
    "Integrity",
    "Kindness",
    "Loyalty",
    "Open-mindedness",
    "Optimism",
    "Perseverance",
    "Positivity",
    "Reliability",
    "Respect"
  ];
  List<String> template4Topic1Question2Strings = [
    "Commitment",
    "Authenticity",
    "Compassion",
    "Connectedness",
    "Concern for others",
    "Consistency",
    "Courage",
    "Dependability",
    "Fearlessness",
    "Friendliness",
    "Good humour",
    "Honesty",
    "Honour",
    "Independence",
    "Integrity",
    "Kindness",
    "Loyalty",
    "Open-mindedness",
    "Optimism",
    "Perseverance",
    "Positivity",
    "Reliability",
    "Respect"
  ];
  List<String> template4Topic1Question3Strings = [
    "Commitment",
    "Authenticity",
    "Compassion",
    "Cooperation",
    "Connectedness",
    "Concern for others",
    "Consistency",
    "Courage",
    "Dependability",
    "Fearlessness",
    "Friendliness",
    "Good humour",
    "Honesty",
    "Honour",
    "Independence",
    "Integrity",
    "Kindness",
    "Loyalty",
    "Open-mindedness",
    "Optimism",
    "Perseverance",
    "Positivity",
    "Reliability",
    "Respect"
  ];
  List<String> template4Topic1Question4Strings = [
    "Discipline",
    "Commitment",
    "Authenticity",
    "Compassion",
    "Cooperation",
    "Connectedness",
    "Concern for others",
    "Consistency",
    "Courage",
    "Dependability",
    "Fearlessness",
    "Friendliness",
    "Good humour",
    "Honesty",
    "Honour",
    "Independence",
    "Integrity",
    "Kindness",
    "Loyalty",
    "Open-mindedness",
    "Optimism",
    "Perseverance",
    "Positivity",
    "Reliability",
    "Respect"
  ];
  List<String> template4Topic1Question5Strings = [
    "Commitment",
    "Authenticity",
    "Compassion",
    "Cooperation",
    "Connectedness",
    "Consistency",
    "Courage",
    "Fearlessness",
    "Open-mindedness",
    "Optimism",
    "Perseverance",
    "Positivity",
    "Discipline"
  ];
  List<DropdownMenuItem<String>> template4Topic1Question1Options;
  List<DropdownMenuItem<String>> template4Topic1Question2Options;
  List<DropdownMenuItem<String>> template4Topic1Question3Options;
  List<DropdownMenuItem<String>> template4Topic1Question4Options;
  List<DropdownMenuItem<String>> template4Topic1Question5Options;

  //Topic 2 : Taking charge
  Map template4Topic2 = {};
  List<String> template4Topic2Question1Strings = [
    "How I respond to my emotions & feelings",
    "How I respond to my thoughts",
    "How I respond to my sensations",
    "How I respond to my memories",
    "How much action I take towards my goals",
    "How much I focus on & engage in what I do",
    "How much I use my values for motivation",
    "Whether or not I act like the sort of person I want to be",
    "What I say and do to influence the future",
    "How I respond to thoughts about the past",
    "Being self-compassionate when losses occur",
    "The values I live by",
    "How I take care of and look after myself",
    "My habits",
    "Stay away from people I don’t want to be around"
  ];
  List<String> template4Topic2Question2Strings = [
    "What I say and do to influence other people",
    "The people around me",
    "The outcome (to some extent)"
  ];
  List<String> template4Topic2Question3Strings = [
    "How someone else behaves",
    "The future"
  ];
  List<DropdownMenuItem<String>> template4Topic2Question1Options;
  List<DropdownMenuItem<String>> template4Topic2Question2Options;
  List<DropdownMenuItem<String>> template4Topic2Question3Options;

  //Fields related to Template 5

  int currentStep = -1;
  // TextEditingController step1 = TextEditingController();
  // TextEditingController step2 = TextEditingController();
  // TextEditingController step3 = TextEditingController();
  // TextEditingController step4 = TextEditingController();
  // TextEditingController step5 = TextEditingController();
  List<TextEditingController> stepTexts = [];

  //Functions
  void updateStep(int step) {
    currentStep = step;
    notifyListeners();
  }

  void template2Topic3MarkCheckBox(String value) {
    if (value == "Yes") {
      template2Topic3Yes = true;
      template2Topic3No = false;
    } else if (value == "No") {
      template2Topic3Yes = false;
      template2Topic3No = true;
    }
    notifyListeners();
  }

  void template3Topic1MarkCheckBox(String value) {
    if (value == "Yes") {
      template3Topic1Yes = true;
      template3Topic1No = false;
    } else if (value == "No") {
      template3Topic1Yes = false;
      template3Topic1No = true;
    }
    notifyListeners();
  }

  void template3Topic6MarkCheckBox(String value) {
    if (value == "Yes") {
      template3Topic6Yes = true;
      template3Topic6No = false;
    } else if (value == "No") {
      template3Topic6Yes = false;
      template3Topic6No = true;
    }
    notifyListeners();
  }

  void changeAnswer(String title, String id, String value) {
    if (title == "Living a life of meaning and purpose") {
      if (id == "1a")
        template4Topic1Answer1a = value;
      else if (id == "1b")
        template4Topic1Answer1b = value;
      else if (id == "1c") template4Topic1Answer1c = value;
      if (id == "2a")
        template4Topic1Answer2a = value;
      else if (id == "2b")
        template4Topic1Answer2b = value;
      else if (id == "2c") template4Topic1Answer2c = value;
      if (id == "3a")
        template4Topic1Answer3a = value;
      else if (id == "3b")
        template4Topic1Answer3b = value;
      else if (id == "3c") template4Topic1Answer3c = value;
      if (id == "4a")
        template4Topic1Answer4a = value;
      else if (id == "4b")
        template4Topic1Answer4b = value;
      else if (id == "4c") template4Topic1Answer4c = value;
      if (id == "5a")
        template4Topic1Answer5a = value;
      else if (id == "5b")
        template4Topic1Answer5b = value;
      else if (id == "5c")
        template4Topic1Answer5c = value;
      else {}
    }
    if (title == "Taking charge") {
      if (id == "1a")
        template4Topic2Answer1a = value;
      else if (id == "1b")
        template4Topic2Answer1b = value;
      else if (id == "1c") template4Topic2Answer1c = value;
      if (id == "2a") template4Topic2Answer2a = value;
      if (id == "3a")
        template4Topic2Answer3a = value;
      else {}
    } else {}
    notifyListeners();
  }

  void updateRank(int rank, WorksheetsDetailsViewModel viewModel) {
    currentRank = rank;
    notifyListeners();
  }

  void goBackToPreviousPage(bool cameBackFromCBTPage) async {
    if (cameBackFromCBTPage)
      _navigationService.back();
    else
      _navigationService.clearTillFirstAndShowView(HomeView(0, 1));
  }

  void markCheckBox(String value) {
    if (value == "yes") {
      yes = true;
      no = false;
    }
    if (value == "no") {
      yes = false;
      no = true;
    }
    notifyListeners();
  }

  void addNewElement() {
    TextEditingController controller = new TextEditingController();
    buildBasicModelBoxes.add(controller);
    notifyListeners();
  }

  void createWhatCanIDoList(List list) {
    whatCanIDo = [];
    for (var controller in list) {
      whatCanIDo.add(controller.text);
    }
  }

  Future getABCDEModelData(String uid, DateTime date) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc("ABCDEModel")
        .get()
        .then((value) {
      if (value.data() != null) {
        log.i("ABCDE Model data present in backend");
        Map data = value.data();
        abcdeModelInternal.text = data["internal"];
        abcdeModelExternal.text = data["external"];
        abcdeModelAssumptions.text = data["assumptions"];
        abcdeModelFactual.text = data["factual"];
        abcdeModelBehavioral.text = data["behavioral"];
        abcdeModelEmotional.text = data["emotional"];
        abcdeModelPhysiological.text = data["physiological"];
        abcdeModelDisputation.text = data["disputation"];
        abcdeModelEffect.text = data["effect"];
        notifyListeners();
        return value.data();
      } else {
        log.i("ABCDE Model data not present in backend");
      }
    });
  }

  Future getSocialActivationModelData(String uid, DateTime date) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc("SocialActivation")
        .get()
        .then((value) {
      if (value.data() != null) {
        log.i("Social Activation Model data present in backend");
        Map data = value.data();
        socialActivationPeopleToCall.text = data["peopleToCall"];
        socialActivationActivity.text = data["activity"];
        socialActivationSchedule.text = data["schedule"];
        socialActivationActivityThought.text = data["activityThought"];
        socialActivationActivityReality.text = data["activityReality"];
        notifyListeners();
        return value.data();
      } else {
        log.i("Social Activation Model data not present in backend");
      }
    });
  }

  Future getBehavioralActivationModelData(String uid, DateTime date) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc("BehavioralActivation")
        .get()
        .then((value) {
      if (value.data() != null) {
        log.i("Behavioral Activation Model data present in backend");
        Map data = value.data();
        currentRank = data["rank"];
        notifyListeners();
        return value.data();
      } else {
        log.i("Behavioral Activation Model data not present in backend");
      }
    });
  }

  Future getBasicModelData(
      String uid, String worksheetname, DateTime date) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc("$worksheetname")
        .get()
        .then((value) {
      if (value.data() != null) {
        log.i("$worksheetname data present in backend");
        Map data = value.data();
        worryingAbout.text = data["worryingAbout"];
        yes = data["canItBeSolved"];
        no = !yes;
        whatCanIDo = data["whatCanYouDo"];
        buildBasicModelBoxes = [];
        for (String text in whatCanIDo) {
          TextEditingController controller = new TextEditingController();
          controller.text = text;
          buildBasicModelBoxes.add(controller);
        }
        notifyListeners();
        return value.data();
      } else {
        log.i("$worksheetname data not present in backend");
      }
    });
  }

  Future getTemplate1(String uid, String worksheetname, DateTime date) async {
    setBusy(true);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc("$worksheetname")
        .get()
        .then((value) {
      if (value.exists) {
        if (worksheetname == "4A'sofstress") {
          template1Topic1["answers"]
              .add(TextEditingController(text: value["answers"][0]));
          template1Topic1["answers"]
              .add(TextEditingController(text: value["answers"][1]));
          template1Topic1["answers"]
              .add(TextEditingController(text: value["answers"][2]));
          template1Topic1["answers"]
              .add(TextEditingController(text: value["answers"][3]));
        } else if (worksheetname == "Eisenhower'sTimeManagementMatrix") {
          template1Topic2["answers"]
              .add(TextEditingController(text: value["answers"][0]));
          template1Topic2["answers"]
              .add(TextEditingController(text: value["answers"][1]));
          template1Topic2["answers"]
              .add(TextEditingController(text: value["answers"][2]));
          template1Topic2["answers"]
              .add(TextEditingController(text: value["answers"][3]));
        }
      } else {
        if (worksheetname == "4A'sofstress") {
          template1Topic1["answers"].add(TextEditingController());
          template1Topic1["answers"].add(TextEditingController());
          template1Topic1["answers"].add(TextEditingController());
          template1Topic1["answers"].add(TextEditingController());
        } else if (worksheetname == "Eisenhower'sTimeManagementMatrix") {
          template1Topic2["answers"].add(TextEditingController());
          template1Topic2["answers"].add(TextEditingController());
          template1Topic2["answers"].add(TextEditingController());
          template1Topic2["answers"].add(TextEditingController());
        }
      }
    });
    notifyListeners();
    setBusy(false);
  }

  Future getTemplate2(String uid, String worksheetname, DateTime date) async {
    setBusy(true);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc("$worksheetname")
        .get()
        .then((value) {
      if (value.exists) {
        if (worksheetname == "TurningStressIntoAction") {
          for (int i = 1; i <= 6; i++) {
            template2Topic1["answers"].add(List.generate(
                value["answers$i"].length,
                (index) => new TextEditingController(
                    text: value["answers$i"][index])));
          }
        } else if (worksheetName == 'Ruleofthree') {
          for (int i = 1; i <= 6; i++) {
            template2Topic2["answers"].add(List.generate(
                value["answers$i"].length,
                (index) => new TextEditingController(
                    text: value["answers$i"][index])));
          }
        } else if (worksheetName == 'Stopworryingaboutthefuture') {
          for (int i = 1; i <= 7; i++) {
            template2Topic3["answers"].add(List.generate(
                value["answers$i"].length,
                (index) => new TextEditingController(
                    text: value["answers$i"][index])));
          }
          template2Topic3Yes = value['template2Topic3Yes'];
          template2Topic3No = value['template2Topic3No'];
        }
      } else {
        if (worksheetname == "TurningStressIntoAction") {
          template2Topic1["answers"] = [
            [new TextEditingController()],
            [
              new TextEditingController(),
              new TextEditingController(),
              new TextEditingController(),
              new TextEditingController()
            ],
            [],
            [new TextEditingController()],
            [new TextEditingController()],
            [
              new TextEditingController(),
              new TextEditingController(),
              new TextEditingController(),
              new TextEditingController()
            ],
          ];
        } else if (worksheetName == 'Ruleofthree') {
          template2Topic2["answers"] = [
            [new TextEditingController()],
            [
              new TextEditingController(),
              new TextEditingController(),
              new TextEditingController(),
            ],
            [new TextEditingController()],
            [new TextEditingController()],
            [new TextEditingController()],
            [new TextEditingController()]
          ];
        } else if (worksheetName == 'Stopworryingaboutthefuture') {
          template2Topic3["answers"] = [
            [new TextEditingController()],
            [new TextEditingController()],
            [
              new TextEditingController(),
              new TextEditingController(),
              new TextEditingController(),
              new TextEditingController()
            ],
            [new TextEditingController()],
            [],
            [new TextEditingController()],
            [new TextEditingController()]
          ];
          template2Topic3Yes = false;
          template2Topic3No = false;
        }
      }
    });
    notifyListeners();
    setBusy(false);
  }

  Future getTemplate3(String uid, String worksheetname, DateTime date) async {
    setBusy(true);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc("$worksheetname")
        .get()
        .then((value) {
      if (value.exists) {
        if (worksheetname == 'ReframingourSHOULDstatements') {
          template3Topic1Yes = value["template3Topic1Yes"];
          template3Topic1No = value["template3Topic1No"];
          for (int i = 1; i <= 6; i++)
            template3Topic1["answers"].add(List.generate(
                value["answers$i"].length,
                (index) => new TextEditingController(
                    text: value["answers$i"][index])));
        } else if (worksheetname == "What'sstoppingyoufromtakingabreak") {
          for (int i = 1; i <= 6; i++)
            template3Topic2["answers"].add(List.generate(
                value["answers$i"].length,
                (index) => new TextEditingController(
                    text: value["answers$i"][index])));
        } else if (worksheetname == 'LessisMore') {
          for (int i = 1; i <= 6; i++)
            template3Topic3["answers"].add(List.generate(
                value["answers$i"].length,
                (index) => new TextEditingController(
                    text: value["answers$i"][index])));
        } else if (worksheetname == 'QuestioningOurAssumptions') {
          for (int i = 1; i <= 8; i++)
            template3Topic4["answers"].add(List.generate(
                value["answers$i"].length,
                (index) => new TextEditingController(
                    text: value["answers$i"][index])));
        } else if (worksheetname == 'TappingintoourResources') {
          for (int i = 1; i <= 6; i++)
            template3Topic5["answers"].add(List.generate(
                value["answers$i"].length,
                (index) => new TextEditingController(
                    text: value["answers$i"][index])));
        } else if (worksheetname == 'ThoughtRecord') {
          template3Topic6Yes = value["template3Topic6Yes"];
          template3Topic6No = value["template3Topic6No"];
          for (int i = 1; i <= 7; i++)
            template3Topic6["answers"].add(List.generate(
                value["answers$i"].length,
                (index) => new TextEditingController(
                    text: value["answers$i"][index])));
        } else if (worksheetname == 'Tinychangeswithbigbenefits') {
          for (int i = 1; i <= 3; i++)
            template3Topic7["answers"].add(List.generate(
                value["answers$i"].length,
                (index) => new TextEditingController(
                    text: value["answers$i"][index])));
        } else if (worksheetname == 'Habits') {
          for (int i = 1; i <= 6; i++)
            template3Topic8["answers"].add(List.generate(
                value["answers$i"].length,
                (index) => new TextEditingController(
                    text: value["answers$i"][index])));
        }
      } else {
        if (worksheetname == 'ReframingourSHOULDstatements') {
          template3Topic1Yes = false;
          template3Topic1No = false;
          template3Topic1["answers"] = List.generate(
              template3Topic1['questions'].length,
              (index) => [new TextEditingController()]);
        } else if (worksheetname == "What'sstoppingyoufromtakingabreak")
          template3Topic2["answers"] = List.generate(
              template3Topic2['questions'].length,
              (index) => [new TextEditingController()]);
        else if (worksheetname == 'LessisMore')
          template3Topic3["answers"] = List.generate(
              template3Topic3['questions'].length,
              (index) => [new TextEditingController()]);
        else if (worksheetname == 'QuestioningOurAssumptions')
          template3Topic4["answers"] = List.generate(
              template3Topic4['questions'].length,
              (index) => [new TextEditingController()]);
        else if (worksheetname == 'TappingintoourResources')
          template3Topic5["answers"] = List.generate(
              template3Topic5['questions'].length,
              (index) => [new TextEditingController()]);
        else if (worksheetname == 'ThoughtRecord') {
          template3Topic6Yes = false;
          template3Topic6No = false;
          template3Topic6["answers"] = List.generate(
              template3Topic6['questions'].length,
              (index) => [new TextEditingController()]);
        } else if (worksheetname == 'Tinychangeswithbigbenefits')
          template3Topic7["answers"] = List.generate(
              template3Topic7['questions'].length,
              (index) => [new TextEditingController()]);
        else if (worksheetname == 'Habits')
          template3Topic8["answers"] = List.generate(
              template3Topic8['questions'].length,
              (index) => [new TextEditingController()]);
      }
    });
    notifyListeners();
    setBusy(false);
  }

  Future getTemplate4(String uid, String worksheetname, DateTime date) async {
    setBusy(true);
    log.i("Getting data for template4: $worksheetname");
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc("$worksheetname")
        .get()
        .then((value) {
      if (value.exists) {
        if (worksheetname == "Livingalifeofmeaningandpurpose") {
          template4Topic1Answer1a = value["1a"];
          template4Topic1Answer1b = value["1b"];
          template4Topic1Answer1c = value["1c"];
          template4Topic1Answer2a = value["2a"];
          template4Topic1Answer2b = value["2b"];
          template4Topic1Answer2c = value["2c"];
          template4Topic1Answer3a = value["3a"];
          template4Topic1Answer3b = value["3b"];
          template4Topic1Answer3c = value["3c"];
          template4Topic1Answer4a = value["4a"];
          template4Topic1Answer4b = value["4b"];
          template4Topic1Answer4c = value["4c"];
          template4Topic1Answer5a = value["5a"];
          template4Topic1Answer5b = value["5b"];
          template4Topic1Answer5c = value["5c"];
        } else {
          template4Topic2Answer1a = value["1a"];
          template4Topic2Answer1b = value["1b"];
          template4Topic2Answer1c = value["1c"];
          template4Topic2Answer2a = value["2a"];
          template4Topic2Answer3a = value["3a"];
        }
      }
    });
    notifyListeners();
    setBusy(false);
  }

  Future getTemplate5(String uid, String worksheetname, DateTime date) async {
    setBusy(true);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc("$worksheetname")
        .get()
        .then((value) {
      if (value.exists) {
        log.i("Found template5 data $worksheetname");
        stepTexts.add(TextEditingController(text: value["step1"]));
        stepTexts.add(TextEditingController(text: value["step2"]));
        stepTexts.add(TextEditingController(text: value["step3"]));
        stepTexts.add(TextEditingController(text: value["step4"]));
        stepTexts.add(TextEditingController(text: value["step5"]));
        currentStep = value["currentStep"];
      } else {
        log.i("Not Found template5 data");
        stepTexts.add(TextEditingController());
        stepTexts.add(TextEditingController());
        stepTexts.add(TextEditingController());
        stepTexts.add(TextEditingController());
        stepTexts.add(TextEditingController());
        currentStep = -1;
      }
    });
    notifyListeners();
    setBusy(false);
  }

  Future fetchData(String uid, String worksheetname, DateTime date) async {
    log.i("Getting worksheet: $worksheetname");
    if (worksheetname == "ABCDEModel") {
      await getABCDEModelData(uid, date);
    } else if (worksheetname == "SocialActivation") {
      await getSocialActivationModelData(uid, date);
    } else if (worksheetname == "BehavioralActivation") {
      await getBehavioralActivationModelData(uid, date);
    } else if (worksheetname == "4A'sofstress" ||
        worksheetname == "Eisenhower'sTimeManagementMatrix") {
      await getTemplate1(uid, worksheetname, date);
    } else if (worksheetName == 'TurningStressIntoAction' ||
        worksheetName == 'Ruleofthree' ||
        worksheetname == 'Stopworryingaboutthefuture') {
      await getTemplate2(uid, worksheetname, date);
    } else if (worksheetname == "ReframingourSHOULDstatements" ||
        worksheetname == "What'sstoppingyoufromtakingabreak" ||
        worksheetname == "LessisMore" ||
        worksheetname == "QuestioningOurAssumptions" ||
        worksheetname == "TappingintoourResources" ||
        worksheetname == "ThoughtRecord" ||
        worksheetname == "Tinychangeswithbigbenefits" ||
        worksheetname == "Habits") {
      await getTemplate3(uid, worksheetname, date);
    } else if (worksheetName == 'Livingalifeofmeaningandpurpose' ||
        worksheetname == 'Takingcharge') {
      await getTemplate4(uid, worksheetname, date);
    } else if (worksheetName == 'Developingtolerancetowardsanxiety') {
      await getTemplate5(uid, worksheetname, date);
    } else {
      await getBasicModelData(uid, worksheetname, date);
    }
  }

  Future updateData(
      String worksheetname, int template, String title, DateTime date) async {
    bool completed;
    if (template == 1) {
      List<String> answers = [];
      if (worksheetname == "4A'sofstress") {
        answers.add(template1Topic1["answers"][0].text);
        answers.add(template1Topic1["answers"][1].text);
        answers.add(template1Topic1["answers"][2].text);
        answers.add(template1Topic1["answers"][3].text);
        template1Topic1["answers"][0].text != '' &&
                template1Topic1["answers"][1].text != '' &&
                template1Topic1["answers"][2].text != '' &&
                template1Topic1["answers"][3].text != ''
            ? completed = true
            : completed = false;
      } else {
        answers.add(template1Topic2["answers"][0].text);
        answers.add(template1Topic2["answers"][1].text);
        answers.add(template1Topic2["answers"][2].text);
        answers.add(template1Topic2["answers"][3].text);
        template1Topic2["answers"][0].text != '' &&
                template1Topic2["answers"][1].text != '' &&
                template1Topic2["answers"][2].text != '' &&
                template1Topic2["answers"][3].text != ''
            ? completed = true
            : completed = false;
      }
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("Worksheets")
          .doc("${DateFormat('dd-MM-yyyy').format(date)}")
          .collection("worksheets")
          .doc("$worksheetname")
          .set({"answers": answers, "completed": completed, "category": title});
    } else if (template == 2) {
      if (worksheetName == 'TurningStressIntoAction') {
        List<String> answers1 = List<String>.generate(
            template2Topic1["answers"][0].length,
            (index) => template2Topic1["answers"][0][index].text);
        List<String> answers2 = List<String>.generate(
            template2Topic1["answers"][1].length,
            (index) => template2Topic1["answers"][1][index].text);
        List<String> answers3 = List<String>.generate(
            template2Topic1["answers"][2].length,
            (index) => template2Topic1["answers"][2][index].text);
        List<String> answers4 = List<String>.generate(
            template2Topic1["answers"][3].length,
            (index) => template2Topic1["answers"][3][index].text);
        List<String> answers5 = List<String>.generate(
            template2Topic1["answers"][4].length,
            (index) => template2Topic1["answers"][4][index].text);
        List<String> answers6 = List<String>.generate(
            template2Topic1["answers"][5].length,
            (index) => template2Topic1["answers"][5][index].text);
        answers1.isNotEmpty &&
                answers2.isNotEmpty &&
                answers4.isNotEmpty &&
                answers5.isNotEmpty
            ? completed = true
            : completed = false;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "answers1": answers1,
          "answers2": answers2,
          "answers3": answers3,
          "answers4": answers4,
          "answers5": answers5,
          "answers6": answers6,
          "completed": completed
        });
      } else if (worksheetName == 'Ruleofthree') {
        List<String> answers1 = List<String>.generate(
            template2Topic2["answers"][0].length,
            (index) => template2Topic2["answers"][0][index].text);
        List<String> answers2 = List<String>.generate(
            template2Topic2["answers"][1].length,
            (index) => template2Topic2["answers"][1][index].text);
        List<String> answers3 = List<String>.generate(
            template2Topic2["answers"][2].length,
            (index) => template2Topic2["answers"][2][index].text);
        List<String> answers4 = List<String>.generate(
            template2Topic2["answers"][3].length,
            (index) => template2Topic2["answers"][3][index].text);
        List<String> answers5 = List<String>.generate(
            template2Topic2["answers"][4].length,
            (index) => template2Topic2["answers"][4][index].text);
        List<String> answers6 = List<String>.generate(
            template2Topic2["answers"][5].length,
            (index) => template2Topic2["answers"][5][index].text);
        answers1 != null &&
                answers2 != null &&
                answers3 != null &&
                answers4 != null &&
                answers5 != null &&
                answers6 != null
            ? completed = true
            : completed = false;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "answers1": answers1,
          "answers2": answers2,
          "answers3": answers3,
          "answers4": answers4,
          "answers5": answers5,
          "answers6": answers6,
          "completed": completed
        });
      } else if (worksheetName == 'Stopworryingaboutthefuture') {
        List<String> answers1 = List<String>.generate(
            template2Topic3["answers"][0].length,
            (index) => template2Topic3["answers"][0][index].text);
        List<String> answers2 = List<String>.generate(
            template2Topic3["answers"][1].length,
            (index) => template2Topic3["answers"][1][index].text);
        List<String> answers3 = List<String>.generate(
            template2Topic3["answers"][2].length,
            (index) => template2Topic3["answers"][2][index].text);
        List<String> answers4 = List<String>.generate(
            template2Topic3["answers"][3].length,
            (index) => template2Topic3["answers"][3][index].text);
        List<String> answers5 = List<String>.generate(
            template2Topic3["answers"][4].length,
            (index) => template2Topic3["answers"][4][index].text);
        List<String> answers6 = List<String>.generate(
            template2Topic3["answers"][5].length,
            (index) => template2Topic3["answers"][5][index].text);
        List<String> answers7 = List<String>.generate(
            template2Topic3["answers"][6].length,
            (index) => template2Topic3["answers"][6][index].text);
        answers1 != null &&
                answers2 != null &&
                answers3 != null &&
                answers4 != null &&
                answers5 != null &&
                answers6 != null &&
                template2Topic3Yes != null &&
                template2Topic3No != null
            ? completed = true
            : completed = false;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "answers1": answers1,
          "answers2": answers2,
          "answers3": answers3,
          "answers4": answers4,
          "answers5": answers5,
          "answers6": answers6,
          "answers7": answers7,
          "template2Topic3Yes": template2Topic3Yes,
          "template2Topic3No": template2Topic3No,
          "completed": completed
        });
      }
    } else if (template == 3) {
      if (worksheetname == 'ReframingourSHOULDstatements') {
        List<String> answers1 = List<String>.generate(
            template3Topic1["answers"][0].length,
            (index) => template3Topic1["answers"][0][index].text);
        List<String> answers2 = List<String>.generate(
            template3Topic1["answers"][1].length,
            (index) => template3Topic1["answers"][1][index].text);
        List<String> answers3 = List<String>.generate(
            template3Topic1["answers"][2].length,
            (index) => template3Topic1["answers"][2][index].text);
        List<String> answers4 = List<String>.generate(
            template3Topic1["answers"][3].length,
            (index) => template3Topic1["answers"][3][index].text);
        List<String> answers5 = List<String>.generate(
            template3Topic1["answers"][4].length,
            (index) => template3Topic1["answers"][4][index].text);
        List<String> answers6 = List<String>.generate(
            template3Topic1["answers"][5].length,
            (index) => template3Topic1["answers"][5][index].text);
        answers1 != null &&
                answers2 != null &&
                answers3 != null &&
                answers4 != null &&
                answers5 != null &&
                answers6 != null &&
                template3Topic1Yes != null &&
                template3Topic1No != null
            ? completed = true
            : completed = false;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "answers1": answers1,
          "answers2": answers2,
          "answers3": answers3,
          "answers4": answers4,
          "answers5": answers5,
          "answers6": answers6,
          "template3Topic1Yes": template3Topic1Yes,
          "template3Topic1No": template3Topic1No,
          "completed": completed
        });
      } else if (worksheetname == "What'sstoppingyoufromtakingabreak") {
        List<String> answers1 = List<String>.generate(
            template3Topic2["answers"][0].length,
            (index) => template3Topic2["answers"][0][index].text);
        List<String> answers2 = List<String>.generate(
            template3Topic2["answers"][1].length,
            (index) => template3Topic2["answers"][1][index].text);
        List<String> answers3 = List<String>.generate(
            template3Topic2["answers"][2].length,
            (index) => template3Topic2["answers"][2][index].text);
        List<String> answers4 = List<String>.generate(
            template3Topic2["answers"][3].length,
            (index) => template3Topic2["answers"][3][index].text);
        List<String> answers5 = List<String>.generate(
            template3Topic2["answers"][4].length,
            (index) => template3Topic2["answers"][4][index].text);
        List<String> answers6 = List<String>.generate(
            template3Topic2["answers"][5].length,
            (index) => template3Topic2["answers"][5][index].text);
        answers1 != null &&
                answers2 != null &&
                answers3 != null &&
                answers4 != null &&
                answers5 != null &&
                answers6 != null
            ? completed = true
            : completed = false;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "answers1": answers1,
          "answers2": answers2,
          "answers3": answers3,
          "answers4": answers4,
          "answers5": answers5,
          "answers6": answers6,
          "completed": completed
        });
      } else if (worksheetname == 'LessisMore') {
        List<String> answers1 = List<String>.generate(
            template3Topic3["answers"][0].length,
            (index) => template3Topic3["answers"][0][index].text);
        List<String> answers2 = List<String>.generate(
            template3Topic3["answers"][1].length,
            (index) => template3Topic3["answers"][1][index].text);
        List<String> answers3 = List<String>.generate(
            template3Topic3["answers"][2].length,
            (index) => template3Topic3["answers"][2][index].text);
        List<String> answers4 = List<String>.generate(
            template3Topic3["answers"][3].length,
            (index) => template3Topic3["answers"][3][index].text);
        List<String> answers5 = List<String>.generate(
            template3Topic3["answers"][4].length,
            (index) => template3Topic3["answers"][4][index].text);
        List<String> answers6 = List<String>.generate(
            template3Topic3["answers"][5].length,
            (index) => template3Topic3["answers"][5][index].text);
        answers1 != null &&
                answers2 != null &&
                answers3 != null &&
                answers4 != null &&
                answers5 != null &&
                answers6 != null
            ? completed = true
            : completed = false;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "answers1": answers1,
          "answers2": answers2,
          "answers3": answers3,
          "answers4": answers4,
          "answers5": answers5,
          "answers6": answers6,
          "completed": completed
        });
      } else if (worksheetname == 'QuestioningOurAssumptions') {
        List<String> answers1 = List<String>.generate(
            template3Topic4["answers"][0].length,
            (index) => template3Topic4["answers"][0][index].text);
        List<String> answers2 = List<String>.generate(
            template3Topic4["answers"][1].length,
            (index) => template3Topic4["answers"][1][index].text);
        List<String> answers3 = List<String>.generate(
            template3Topic4["answers"][2].length,
            (index) => template3Topic4["answers"][2][index].text);
        List<String> answers4 = List<String>.generate(
            template3Topic4["answers"][3].length,
            (index) => template3Topic4["answers"][3][index].text);
        List<String> answers5 = List<String>.generate(
            template3Topic4["answers"][4].length,
            (index) => template3Topic4["answers"][4][index].text);
        List<String> answers6 = List<String>.generate(
            template3Topic4["answers"][5].length,
            (index) => template3Topic4["answers"][5][index].text);
        List<String> answers7 = List<String>.generate(
            template3Topic4["answers"][6].length,
            (index) => template3Topic4["answers"][6][index].text);
        List<String> answers8 = List<String>.generate(
            template3Topic4["answers"][7].length,
            (index) => template3Topic4["answers"][7][index].text);
        answers1 != null &&
                answers2 != null &&
                answers3 != null &&
                answers4 != null &&
                answers5 != null &&
                answers6 != null &&
                answers7 != null &&
                answers8 != null
            ? completed = true
            : completed = false;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "answers1": answers1,
          "answers2": answers2,
          "answers3": answers3,
          "answers4": answers4,
          "answers5": answers5,
          "answers6": answers6,
          "answers7": answers7,
          "answers8": answers8,
          "completed": completed
        });
      } else if (worksheetname == 'TappingintoourResources') {
        List<String> answers1 = List<String>.generate(
            template3Topic5["answers"][0].length,
            (index) => template3Topic5["answers"][0][index].text);
        List<String> answers2 = List<String>.generate(
            template3Topic5["answers"][1].length,
            (index) => template3Topic5["answers"][1][index].text);
        List<String> answers3 = List<String>.generate(
            template3Topic5["answers"][2].length,
            (index) => template3Topic5["answers"][2][index].text);
        List<String> answers4 = List<String>.generate(
            template3Topic5["answers"][3].length,
            (index) => template3Topic5["answers"][3][index].text);
        List<String> answers5 = List<String>.generate(
            template3Topic5["answers"][4].length,
            (index) => template3Topic5["answers"][4][index].text);
        List<String> answers6 = List<String>.generate(
            template3Topic5["answers"][5].length,
            (index) => template3Topic5["answers"][5][index].text);
        answers1 != null &&
                answers2 != null &&
                answers3 != null &&
                answers4 != null &&
                answers5 != null &&
                answers6 != null
            ? completed = true
            : completed = false;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "answers1": answers1,
          "answers2": answers2,
          "answers3": answers3,
          "answers4": answers4,
          "answers5": answers5,
          "answers6": answers6,
          "completed": completed
        });
      } else if (worksheetname == 'ThoughtRecord') {
        List<String> answers1 = List<String>.generate(
            template3Topic6["answers"][0].length,
            (index) => template3Topic6["answers"][0][index].text);
        List<String> answers2 = List<String>.generate(
            template3Topic6["answers"][1].length,
            (index) => template3Topic6["answers"][1][index].text);
        List<String> answers3 = List<String>.generate(
            template3Topic6["answers"][2].length,
            (index) => template3Topic6["answers"][2][index].text);
        List<String> answers4 = List<String>.generate(
            template3Topic6["answers"][3].length,
            (index) => template3Topic6["answers"][3][index].text);
        List<String> answers5 = List<String>.generate(
            template3Topic6["answers"][4].length,
            (index) => template3Topic6["answers"][4][index].text);
        List<String> answers6 = List<String>.generate(
            template3Topic6["answers"][5].length,
            (index) => template3Topic6["answers"][5][index].text);
        List<String> answers7 = List<String>.generate(
            template3Topic6["answers"][6].length,
            (index) => template3Topic6["answers"][6][index].text);
        answers1 != null &&
                answers2 != null &&
                answers3 != null &&
                answers4 != null &&
                answers5 != null &&
                answers6 != null &&
                answers7 != null &&
                template3Topic6Yes != null &&
                template3Topic6No != null
            ? completed = true
            : completed = false;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "answers1": answers1,
          "answers2": answers2,
          "answers3": answers3,
          "answers4": answers4,
          "answers5": answers5,
          "answers6": answers6,
          "answers7": answers7,
          "template3Topic6Yes": template3Topic6Yes,
          "template3Topic6No": template3Topic6No,
          "completed": completed
        });
      } else if (worksheetname == 'Tinychangeswithbigbenefits') {
        List<String> answers1 = List<String>.generate(
            template3Topic7["answers"][0].length,
            (index) => template3Topic7["answers"][0][index].text);
        List<String> answers2 = List<String>.generate(
            template3Topic7["answers"][1].length,
            (index) => template3Topic7["answers"][1][index].text);
        List<String> answers3 = List<String>.generate(
            template3Topic7["answers"][2].length,
            (index) => template3Topic7["answers"][2][index].text);
        answers1 != null && answers2 != null && answers3 != null
            ? completed = true
            : completed = false;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "answers1": answers1,
          "answers2": answers2,
          "answers3": answers3,
          "completed": completed
        });
      } else if (worksheetname == 'Habits') {
        List<String> answers1 = List<String>.generate(
            template3Topic8["answers"][0].length,
            (index) => template3Topic8["answers"][0][index].text);
        List<String> answers2 = List<String>.generate(
            template3Topic8["answers"][1].length,
            (index) => template3Topic8["answers"][1][index].text);
        List<String> answers3 = List<String>.generate(
            template3Topic8["answers"][2].length,
            (index) => template3Topic8["answers"][2][index].text);
        List<String> answers4 = List<String>.generate(
            template3Topic8["answers"][3].length,
            (index) => template3Topic8["answers"][3][index].text);
        List<String> answers5 = List<String>.generate(
            template3Topic8["answers"][4].length,
            (index) => template3Topic8["answers"][4][index].text);
        List<String> answers6 = List<String>.generate(
            template3Topic8["answers"][5].length,
            (index) => template3Topic8["answers"][5][index].text);
        answers1 != null &&
                answers2 != null &&
                answers3 != null &&
                answers4 != null &&
                answers5 != null &&
                answers6 != null
            ? completed = true
            : completed = false;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "answers1": answers1,
          "answers2": answers2,
          "answers3": answers3,
          "answers4": answers4,
          "answers5": answers5,
          "answers6": answers6,
          "completed": completed
        });
      }
    } else if (template == 4) {
      if (worksheetname == "Livingalifeofmeaningandpurpose") {
        completed = template4Topic1Answer1a != null &&
            template4Topic1Answer1b != null &&
            template4Topic1Answer1c != null &&
            template4Topic1Answer2a != null &&
            template4Topic1Answer2b != null &&
            template4Topic1Answer2c != null &&
            template4Topic1Answer3a != null &&
            template4Topic1Answer3b != null &&
            template4Topic1Answer3c != null &&
            template4Topic1Answer4a != null &&
            template4Topic1Answer4b != null &&
            template4Topic1Answer4c != null &&
            template4Topic1Answer5a != null &&
            template4Topic1Answer5b != null &&
            template4Topic1Answer5c != null;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "1a": template4Topic1Answer1a,
          "1b": template4Topic1Answer1b,
          "1c": template4Topic1Answer1c,
          "2a": template4Topic1Answer2a,
          "2b": template4Topic1Answer2b,
          "2c": template4Topic1Answer2c,
          "3a": template4Topic1Answer3a,
          "3b": template4Topic1Answer3b,
          "3c": template4Topic1Answer3c,
          "4a": template4Topic1Answer4a,
          "4b": template4Topic1Answer4b,
          "4c": template4Topic1Answer4c,
          "5a": template4Topic1Answer5a,
          "5b": template4Topic1Answer5b,
          "5c": template4Topic1Answer5c,
          "completed": completed
        });
      } else {
        completed = template4Topic2Answer1a != null &&
            template4Topic2Answer1b != null &&
            template4Topic2Answer1c != null &&
            template4Topic2Answer2a != null &&
            template4Topic2Answer3a != null;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Worksheets")
            .doc("${DateFormat('dd-MM-yyyy').format(date)}")
            .collection("worksheets")
            .doc("$worksheetname")
            .set({
          "1a": template4Topic2Answer1a,
          "1b": template4Topic2Answer1b,
          "1c": template4Topic2Answer1c,
          "2a": template4Topic2Answer2a,
          "3a": template4Topic2Answer3a,
          "completed": completed
        });
      }
    } else if (template == 5) {
      log.i("Updating template 5");
      completed = stepTexts[0].text != null &&
          stepTexts[1].text != null &&
          stepTexts[2].text != null &&
          stepTexts[3].text != null &&
          stepTexts[4].text != null &&
          currentStep != -1;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("Worksheets")
          .doc("${DateFormat('dd-MM-yyyy').format(date)}")
          .collection("worksheets")
          .doc("$worksheetname")
          .set({
        "step1": stepTexts[0].text,
        "step2": stepTexts[1].text,
        "step3": stepTexts[2].text,
        "step4": stepTexts[3].text,
        "step5": stepTexts[4].text,
        "currentStep": currentStep,
      });
    } else if (template == 6) {
      ((abcdeModelInternal.text != '' && abcdeModelInternal.text != null) &&
              (abcdeModelExternal.text != '' &&
                  abcdeModelExternal.text != null) &&
              (abcdeModelAssumptions.text != '' &&
                  abcdeModelAssumptions.text != null) &&
              (abcdeModelFactual.text != '' &&
                  abcdeModelFactual.text != null) &&
              (abcdeModelBehavioral.text != '' &&
                  abcdeModelBehavioral.text != null) &&
              (abcdeModelEmotional.text != '' &&
                  abcdeModelEmotional.text != null) &&
              (abcdeModelPhysiological.text != '' &&
                  abcdeModelPhysiological.text != null) &&
              (abcdeModelDisputation.text != '' &&
                  abcdeModelDisputation.text != null) &&
              (abcdeModelEffect.text != '' && abcdeModelEffect.text != null))
          ? completed = true
          : completed = false;
      log.i("completed : " + completed.toString());
      notifyListeners();
      _firestoreService.updateABCDEModelData(
          date,
          uid,
          abcdeModelInternal.text,
          abcdeModelExternal.text,
          abcdeModelAssumptions.text,
          abcdeModelFactual.text,
          abcdeModelBehavioral.text,
          abcdeModelEmotional.text,
          abcdeModelPhysiological.text,
          abcdeModelDisputation.text,
          abcdeModelEffect.text,
          completed);
    } else if (template == 7) {
      ((socialActivationPeopleToCall.text != '' &&
                  socialActivationPeopleToCall.text != null) &&
              (socialActivationActivity.text != '' &&
                  socialActivationActivity.text != null) &&
              (socialActivationSchedule.text != '' &&
                  socialActivationSchedule.text != null) &&
              (socialActivationActivityThought.text != '' &&
                  socialActivationActivityThought.text != null) &&
              (socialActivationActivityReality.text != '' &&
                  socialActivationActivityReality.text != null))
          ? completed = true
          : completed = false;
      notifyListeners();
      _firestoreService.updateSocialActivationModelData(
          date,
          uid,
          socialActivationPeopleToCall.text,
          socialActivationActivity.text,
          socialActivationSchedule.text,
          socialActivationActivityThought.text,
          socialActivationActivityReality.text,
          completed);
    } else if (template == 8) {
      currentRank != 0 ? completed = true : completed = false;
      notifyListeners();
      _firestoreService.updateBehavioralActivationModelData(
          uid, currentRank, completed, date);
    } else if (template == 9) {
      createWhatCanIDoList(buildBasicModelBoxes);
      ((worryingAbout.text != '' && worryingAbout.text != null) &&
              (whatCanIDo[0] != '') &&
              !(yes == false && no == false))
          ? completed = true
          : completed = false;
      notifyListeners();
      _firestoreService.updateBasicModelData(date,
          uid, worksheetname, worryingAbout.text, yes, whatCanIDo, completed);
    } else {}
  }

  WorksheetsDetailsViewModel(DateTime date, String worksheetName) {
    uid = _authenticationService.user.uid;
    selectedDay = date;
    this.worksheetName = worksheetName;
    buildABCDEModelBoxes = [
      {
        "title": "Activating event • What triggered the problem?",
        "content": ["Internal", "External"],
        "controller": [abcdeModelInternal, abcdeModelExternal]
      },
      {
        "title": "Beliefs • Beliefs about the situation and yourself",
        "content": ["Assumptions(irrational)", "Factual (rational)"],
        "controller": [abcdeModelAssumptions, abcdeModelFactual]
      },
      {
        "title": "Consequences",
        "content": ["Behavioral", "Emotional", "Physiological"],
        "controller": [
          abcdeModelBehavioral,
          abcdeModelEmotional,
          abcdeModelPhysiological
        ]
      },
      {
        "title": "Disputation • How can we challenge our false beliefs",
        "content": [""],
        "controller": [abcdeModelDisputation]
      },
      {
        "title": "Effect • What is the new effect or healthier consequences",
        "content": [""],
        "controller": [abcdeModelEffect]
      },
    ];
    buildSocialActivationModelBoxes = [
      {
        "title": "Name 2 people you can call",
        "controller": socialActivationPeopleToCall
      },
      {
        "title": "Think of an activity you can plan with them",
        "controller": socialActivationActivity
      },
      {
        "title": "When will you schedule this for",
        "controller": socialActivationSchedule
      },
      {
        "title": "How do you think you will feel after this activity",
        "controller": socialActivationActivityThought
      },
      {
        "title": "How do you actually feel? Come back after the activity",
        "controller": socialActivationActivityReality
      },
    ];
    // stepTexts = [step1, step2, step3, step4, step5];
    template4Topic1Question1Options = List.generate(
        template4Topic1Question1Strings.length,
        (index) => DropdownMenuItem<String>(
              child: Text('${template4Topic1Question1Strings[index]}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              value: template4Topic1Question1Strings[index],
            ));
    template4Topic1Question2Options = List.generate(
        template4Topic1Question2Strings.length,
        (index) => DropdownMenuItem<String>(
              child: Text('${template4Topic1Question2Strings[index]}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              value: template4Topic1Question2Strings[index],
            ));
    template4Topic1Question3Options = List.generate(
        template4Topic1Question3Strings.length,
        (index) => DropdownMenuItem<String>(
              child: Text('${template4Topic1Question3Strings[index]}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              value: template4Topic1Question3Strings[index],
            ));
    template4Topic1Question4Options = List.generate(
        template4Topic1Question4Strings.length,
        (index) => DropdownMenuItem<String>(
              child: Text('${template4Topic1Question4Strings[index]}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              value: template4Topic1Question4Strings[index],
            ));
    template4Topic1Question5Options = List.generate(
        template4Topic1Question5Strings.length,
        (index) => DropdownMenuItem<String>(
              child: Text('${template4Topic1Question5Strings[index]}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              value: template4Topic1Question5Strings[index],
            ));
    template4Topic2Question1Options = List.generate(
        template4Topic2Question1Strings.length,
        (index) => DropdownMenuItem<String>(
              child: Text('${template4Topic2Question1Strings[index]}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              value: template4Topic2Question1Strings[index],
            ));
    template4Topic2Question2Options = List.generate(
        template4Topic2Question2Strings.length,
        (index) => DropdownMenuItem<String>(
              child: Text('${template4Topic2Question2Strings[index]}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              value: template4Topic2Question2Strings[index],
            ));
    template4Topic2Question3Options = List.generate(
        template4Topic2Question3Strings.length,
        (index) => DropdownMenuItem<String>(
              child: Text('${template4Topic2Question3Strings[index]}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              value: template4Topic2Question3Strings[index],
            ));
    template4Topic1 = {
      "title": "Living a life of meaning and purpose",
      "summary":"When we’re stressed or overwhelmed, we often feel like nothing is in our hands which often leads to feelings of helplessness and even more stress. But if you look closely, you’ll notice a lot is in your control. And if things aren't entirely in your control, there are areas you can exercise your influence, and we can focus on that. But the first and most important part is knowing what you want. Now, let's take a moment to think about how this looks like for you…",
      "questions": [
        "Identify your core FAMILY Values",
        "Identify your core RELATIONSHIP Values",
        "Identify your core FRIENDSHIP Values",
        "Identify your core WORK Values",
        "Identify your core HEALTH/FITNESS Values",
      ],
      "options": [
        template4Topic1Question1Options,
        template4Topic1Question2Options,
        template4Topic1Question3Options,
        template4Topic1Question4Options,
        template4Topic1Question5Options
      ]
    };
    template4Topic2 = {
      "title": "Taking charge",
      "summary":
          "When we’re stressed or overwhelmed, we often feel like nothing is in our hands which often leads to feelings of helplessness and even more stress. But if you look closely, you’ll notice a lot is in your control. And if things arent entirely in your control, there are areas you can exercise your influence, and we can focus on that. But the first and most important part is knowing what you want.\nNow lets take a moment to think about how this looks like for you…",
      "questions": [
        "Things that are in your CONTROL",
        "Things that you can INFLUENCE",
        "Things that you CANNOT FULLY CONTROL",
      ],
      "options": [
        template4Topic2Question1Options,
        template4Topic2Question2Options,
        template4Topic2Question3Options,
      ]
    };
    buildBasicModelBoxes = [whatCanIDoAboutThis];
    notifyListeners();
    log = getLogger(this.runtimeType.toString());
  }

  @override
  Future futureToRun() async {
    log.i("worksheetName: $worksheetName");
    futureForWorksheetModels = await fetchData(uid, worksheetName, selectedDay);
  }
}
