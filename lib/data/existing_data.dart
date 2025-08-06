import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadQuestionsToFirebase() async {
  for (final sector in data.entries) {
    uploadQuestionsForAField(sector.key, sector.value);
  }
}

Future<void> uploadQuestionsForAField(String field, dynamic data) async {
  FirebaseFirestore.instance
      .collection('ListOfQuestions')
      .doc(field)
      .set(data)
      .then((_) {
        print('Data for "$field" uploaded successfully');
      })
      .catchError((error) {
        print('Failed to upload data for "$field": $error');
      });
}

final data = {
  "Flutter": {
    "title": "Flutter",
    "image_url":
        "https://litslink.com/wp-content/uploads/2020/03/flutter-app-featured.png",
    "questions": {
      "0": {
        "correctOptionKey": "1",
        "options": {"1": "number", "2": "int", "3": "String", "4": "bool"},
        "questionText": "Which of the following is NOT a valid Dart data type?",
      },
      "1": {
        "correctOptionKey": "3",
        "options": {"1": "Column", "2": "Row", "3": "Layout", "4": "Stack"},
        "questionText": "Which of the following is NOT a Flutter widget?",
      },
      "2": {
        "correctOptionKey": "4",
        "options": {
          "1": "runApp()",
          "2": "main()",
          "3": "MaterialApp()",
          "4": "@override Widget build()",
        },
        "questionText": "Which function is used to build a widget in Flutter?",
      },
      "3": {
        "correctOptionKey": "2",
        "options": {
          "1": "stateful",
          "2": "StatefulWidget",
          "3": "stateless",
          "4": "StatefulApp",
        },
        "questionText":
            "Which one is the correct class for a widget that holds state?",
      },
      "4": {
        "correctOptionKey": "3",
        "options": {
          "1": "Text()",
          "2": "Image()",
          "3": "NetworkImage()",
          "4": "Container()",
        },
        "questionText":
            "Which of the following is used to load images from the internet?",
      },
      "5": {
        "correctOptionKey": "4",
        "options": {
          "1": "Scaffold",
          "2": "SafeArea",
          "3": "AppBar",
          "4": "setState()",
        },
        "questionText":
            "Which method is used to update the UI inside a StatefulWidget?",
      },
      "6": {
        "correctOptionKey": "1",
        "options": {
          "1": "DartPad",
          "2": "Visual Studio",
          "3": "Android XML",
          "4": "React Native",
        },
        "questionText":
            "Which tool is specifically designed for trying Dart/Flutter code online?",
      },
      "7": {
        "correctOptionKey": "2",
        "options": {
          "1": "padding",
          "2": "Padding",
          "3": "padding()",
          "4": "Spacing",
        },
        "questionText": "Which widget is used to add space around a widget?",
      },
      "8": {
        "correctOptionKey": "4",
        "options": {
          "1": "pub build",
          "2": "flutter start",
          "3": "flutter init",
          "4": "flutter pub get",
        },
        "questionText":
            "Which command is used to fetch Flutter package dependencies?",
      },
      "9": {
        "correctOptionKey": "3",
        "options": {
          "1": "Text()",
          "2": "Image.asset()",
          "3": "Scaffold()",
          "4": "MaterialColor",
        },
        "questionText":
            "Which widget provides a basic visual layout structure in Flutter?",
      },
    },
  },
  "Python": {
    "title": "Python",
    "image_url":
        "https://www.python.org/static/community_logos/python-logo.png",
    "questions": {
      "0": {
        "questionText": "Which of these is not a Python data type?",
        "options": {"1": "list", "2": "tuple", "3": "map", "4": "set"},
        "correctOptionKey": "3",
      },
      "1": {
        "questionText": "How do you start a function in Python?",
        "options": {"1": "function", "2": "def", "3": "fun", "4": "method"},
        "correctOptionKey": "2",
      },
      "2": {
        "questionText": "What is the output of: len([1, 2, 3])?",
        "options": {"1": "2", "2": "3", "3": "4", "4": "Error"},
        "correctOptionKey": "2",
      },
      "3": {
        "questionText": "Which keyword is used for loops in Python?",
        "options": {"1": "loop", "2": "iterate", "3": "for", "4": "repeat"},
        "correctOptionKey": "3",
      },
      "4": {
        "questionText": "How do you comment a single line in Python?",
        "options": {"1": "//", "2": "/* */", "3": "#", "4": "--"},
        "correctOptionKey": "3",
      },
      "5": {
        "questionText": "What is used to handle exceptions?",
        "options": {
          "1": "try-except",
          "2": "do-catch",
          "3": "error-handling",
          "4": "try-catch",
        },
        "correctOptionKey": "1",
      },
      "6": {
        "questionText": "Which library is used for data analysis?",
        "options": {
          "1": "NumPy",
          "2": "Pandas",
          "3": "TensorFlow",
          "4": "Matplotlib",
        },
        "correctOptionKey": "2",
      },
      "7": {
        "questionText": "Which of these is a Python web framework?",
        "options": {"1": "Laravel", "2": "Django", "3": "Spring", "4": "Flask"},
        "correctOptionKey": "2",
      },
      "8": {
        "questionText": "What does pip stand for?",
        "options": {
          "1": "Python Installation Package",
          "2": "Preferred Installer Program",
          "3": "Package Integration Python",
          "4": "None",
        },
        "correctOptionKey": "2",
      },
      "9": {
        "questionText": "Which operator is used for exponentiation?",
        "options": {"1": "^", "2": "*", "3": "**", "4": "exp"},
        "correctOptionKey": "3",
      },
    },
  },
  "HTML": {
    "title": "HTML",
    "image_url":
        "https://upload.wikimedia.org/wikipedia/commons/6/61/HTML5_logo_and_wordmark.svg",
    "questions": {
      "0": {
        "questionText": "What does HTML stand for?",
        "options": {
          "1": "HyperText Markup Language",
          "2": "HighText Machine Language",
          "3": "HyperTabular Markup Language",
          "4": "None of these",
        },
        "correctOptionKey": "1",
      },
      "1": {
        "questionText": "Which tag is used to create a hyperlink?",
        "options": {"1": "<a>", "2": "<link>", "3": "<href>", "4": "<hyper>"},
        "correctOptionKey": "1",
      },
      "2": {
        "questionText": "Which HTML element is used for the largest heading?",
        "options": {"1": "<h6>", "2": "<heading>", "3": "<h1>", "4": "<head>"},
        "correctOptionKey": "3",
      },
      "3": {
        "questionText":
            "What is the correct HTML element for inserting a line break?",
        "options": {"1": "<lb>", "2": "<br>", "3": "<break>", "4": "<newline>"},
        "correctOptionKey": "2",
      },
      "4": {
        "questionText": "Which tag is used to display an image?",
        "options": {"1": "<img>", "2": "<image>", "3": "<src>", "4": "<pic>"},
        "correctOptionKey": "1",
      },
      "5": {
        "questionText":
            "Which attribute specifies the image source in the <img> tag?",
        "options": {"1": "href", "2": "src", "3": "alt", "4": "link"},
        "correctOptionKey": "2",
      },
      "6": {
        "questionText":
            "Which HTML tag is used to define an internal style sheet?",
        "options": {
          "1": "<script>",
          "2": "<style>",
          "3": "<css>",
          "4": "<link>",
        },
        "correctOptionKey": "2",
      },
      "7": {
        "questionText": "What is the correct way to make a numbered list?",
        "options": {"1": "<ul>", "2": "<ol>", "3": "<list>", "4": "<dl>"},
        "correctOptionKey": "2",
      },
      "8": {
        "questionText": "What does the <title> tag do?",
        "options": {
          "1": "Defines the page body",
          "2": "Displays the page's title in the browser tab",
          "3": "Displays heading",
          "4": "Adds a tooltip",
        },
        "correctOptionKey": "2",
      },
      "9": {
        "questionText": "Which input type allows the user to select a file?",
        "options": {"1": "text", "2": "file", "3": "upload", "4": "choose"},
        "correctOptionKey": "2",
      },
    },
  },
  "Network": {
    "title": "Network",
    "image_url":
        "https://miro.medium.com/v2/resize:fit:1200/1*tnqSssUQ3abgy2hq5IYqDQ.jpeg",
    "questions": {
      "0": {
        "questionText": "What does IP stand for?",
        "options": {
          "1": "Internet Protocol",
          "2": "Internal Port",
          "3": "Internet Process",
          "4": "Intranet Protocol",
        },
        "correctOptionKey": "1",
      },
      "1": {
        "questionText": "Which device connects multiple networks together?",
        "options": {"1": "Switch", "2": "Router", "3": "Hub", "4": "Bridge"},
        "correctOptionKey": "2",
      },
      "2": {
        "questionText": "What is the purpose of a MAC address?",
        "options": {
          "1": "To locate websites",
          "2": "To identify hardware",
          "3": "To assign DNS",
          "4": "To encrypt data",
        },
        "correctOptionKey": "2",
      },
      "3": {
        "questionText": "What layer of the OSI model does TCP operate on?",
        "options": {
          "1": "Data Link",
          "2": "Network",
          "3": "Transport",
          "4": "Application",
        },
        "correctOptionKey": "3",
      },
      "4": {
        "questionText":
            "Which protocol is used to assign IP addresses automatically?",
        "options": {"1": "DNS", "2": "HTTP", "3": "DHCP", "4": "FTP"},
        "correctOptionKey": "3",
      },
      "5": {
        "questionText": "What does DNS do?",
        "options": {
          "1": "Translates domain names to IP addresses",
          "2": "Encrypts network traffic",
          "3": "Connects switches",
          "4": "Creates websites",
        },
        "correctOptionKey": "1",
      },
      "6": {
        "questionText": "Which of these is a private IP address?",
        "options": {
          "1": "192.168.0.1",
          "2": "8.8.8.8",
          "3": "172.0.0.1",
          "4": "10.0.0.1",
        },
        "correctOptionKey": "1",
      },
      "7": {
        "questionText": "What does HTTP stand for?",
        "options": {
          "1": "HyperText Transfer Protocol",
          "2": "HighText Transmission Process",
          "3": "Host Transfer Protocol",
          "4": "Hyper Transfer Protocol",
        },
        "correctOptionKey": "1",
      },
      "8": {
        "questionText": "What is the standard port for HTTPS?",
        "options": {"1": "443", "2": "80", "3": "21", "4": "53"},
        "correctOptionKey": "1",
      },
      "9": {
        "questionText": "What device amplifies signals in a network?",
        "options": {
          "1": "Repeater",
          "2": "Router",
          "3": "Modem",
          "4": "Firewall",
        },
        "correctOptionKey": "1",
      },
    },
  },
  "Security": {
    "title": "Security",
    "image_url":
        "https://www.securitymagazine.com/ext/resources/Default-images/2022/01/cyber-security-freepik1170.jpg",
    "questions": {
      "0": {
        "questionText": "What does SSL stand for?",
        "options": {
          "1": "Secure Sockets Layer",
          "2": "System Socket Link",
          "3": "Secure System Layer",
          "4": "Software Secure Lock",
        },
        "correctOptionKey": "1",
      },
      "1": {
        "questionText": "Which of the following is a type of malware?",
        "options": {
          "1": "Firewall",
          "2": "VPN",
          "3": "Ransomware",
          "4": "Proxy",
        },
        "correctOptionKey": "3",
      },
      "2": {
        "questionText": "What is the primary purpose of a firewall?",
        "options": {
          "1": "To detect viruses",
          "2": "To filter incoming and outgoing traffic",
          "3": "To store passwords",
          "4": "To speed up the internet",
        },
        "correctOptionKey": "2",
      },
      "3": {
        "questionText": "Which of these is considered a strong password?",
        "options": {
          "1": "12345678",
          "2": "password",
          "3": "admin123",
          "4": "T!m3#@re#2049",
        },
        "correctOptionKey": "4",
      },
      "4": {
        "questionText": "What does 2FA stand for?",
        "options": {
          "1": "Two-Factor Authentication",
          "2": "Two-Firewall Access",
          "3": "Twice File Access",
          "4": "Token For Authorization",
        },
        "correctOptionKey": "1",
      },
      "5": {
        "questionText": "Which tool is commonly used for penetration testing?",
        "options": {
          "1": "Kali Linux",
          "2": "MySQL",
          "3": "Photoshop",
          "4": "Slack",
        },
        "correctOptionKey": "1",
      },
      "6": {
        "questionText": "What is phishing?",
        "options": {
          "1": "A hacking technique that involves capturing keystrokes",
          "2": "Sending fraudulent emails to steal information",
          "3": "Scanning networks for open ports",
          "4": "Testing software for bugs",
        },
        "correctOptionKey": "2",
      },
      "7": {
        "questionText": "What is a VPN used for?",
        "options": {
          "1": "Tracking online users",
          "2": "Blocking ads",
          "3": "Securely connecting to a network",
          "4": "Speeding up downloads",
        },
        "correctOptionKey": "3",
      },
      "8": {
        "questionText": "Which of the following is an encryption algorithm?",
        "options": {"1": "SHA-1", "2": "MD5", "3": "AES", "4": "Ping"},
        "correctOptionKey": "3",
      },
      "9": {
        "questionText": "What does the principle of 'least privilege' mean?",
        "options": {
          "1": "Granting all users admin rights",
          "2": "Only giving necessary permissions",
          "3": "Letting users access all files",
          "4": "Blocking internet access",
        },
        "correctOptionKey": "2",
      },
    },
  },
  "Frontend": {
    "title": "Frontend",
    "image_url": "https://cdn.mos.cms.futurecdn.net/mquGevDFuz8MVeEo2iChy9.jpg",
    "questions": {
      "0": {
        "questionText": "What does HTML stand for?",
        "options": {
          "1": "Hyper Trainer Marking Language",
          "2": "Hyper Text Markup Language",
          "3": "Hyper Text Markdown Language",
          "4": "Highlevel Text Managing Language",
        },
        "correctOptionKey": "2",
      },
      "1": {
        "questionText": "Which tag is used to create a hyperlink in HTML?",
        "options": {"1": "<link>", "2": "<a>", "3": "<href>", "4": "<src>"},
        "correctOptionKey": "2",
      },
      "2": {
        "questionText": "What is the main purpose of CSS?",
        "options": {
          "1": "Structure the page",
          "2": "Style and layout the content",
          "3": "Handle backend logic",
          "4": "Add database functionality",
        },
        "correctOptionKey": "2",
      },
      "3": {
        "questionText": "Which of the following is NOT a valid CSS unit?",
        "options": {"1": "px", "2": "em", "3": "rem", "4": "kg"},
        "correctOptionKey": "4",
      },
      "4": {
        "questionText": "Which property is used to change text color in CSS?",
        "options": {
          "1": "font-style",
          "2": "text-color",
          "3": "color",
          "4": "text-style",
        },
        "correctOptionKey": "3",
      },
      "5": {
        "questionText": "What does the 'position: absolute;' rule do?",
        "options": {
          "1": "Makes the element scrollable",
          "2": "Fixes it to screen edge",
          "3": "Positions it relative to nearest positioned ancestor",
          "4": "Hides the element",
        },
        "correctOptionKey": "3",
      },
      "6": {
        "questionText":
            "Which language is used for adding interactivity to websites?",
        "options": {"1": "HTML", "2": "CSS", "3": "JavaScript", "4": "SQL"},
        "correctOptionKey": "3",
      },
      "7": {
        "questionText": "What does DOM stand for?",
        "options": {
          "1": "Document Object Model",
          "2": "Digital Object Marker",
          "3": "Data Output Management",
          "4": "Document Output Mode",
        },
        "correctOptionKey": "1",
      },
      "8": {
        "questionText":
            "Which HTML tag is used to define a section of navigation links?",
        "options": {
          "1": "<header>",
          "2": "<nav>",
          "3": "<section>",
          "4": "<div>",
        },
        "correctOptionKey": "2",
      },
      "9": {
        "questionText":
            "Which of these frameworks is used for building frontend apps?",
        "options": {"1": "Django", "2": "Laravel", "3": "React", "4": "Spring"},
        "correctOptionKey": "3",
      },
    },
  },
  "Backend": {
    "title": "Backend",
    "image_url":
        "https://kinsta.com/wp-content/uploads/2021/03/backend-development.png",
    "questions": {
      "0": {
        "questionText":
            "Which language is commonly used for backend development?",
        "options": {"1": "HTML", "2": "CSS", "3": "Python", "4": "Photoshop"},
        "correctOptionKey": "3",
      },
      "1": {
        "questionText": "What is a REST API?",
        "options": {
          "1": "A frontend layout tool",
          "2": "A type of database",
          "3": "A protocol for communication between systems",
          "4": "A Python package",
        },
        "correctOptionKey": "3",
      },
      "2": {
        "questionText": "Which HTTP method is used to create data?",
        "options": {"1": "GET", "2": "POST", "3": "DELETE", "4": "PUT"},
        "correctOptionKey": "2",
      },
      "3": {
        "questionText": "What does SQL stand for?",
        "options": {
          "1": "Structured Query Language",
          "2": "Secure Query Logic",
          "3": "Simple Queue Line",
          "4": "System Query Language",
        },
        "correctOptionKey": "1",
      },
      "4": {
        "questionText": "Which of the following is a NoSQL database?",
        "options": {
          "1": "MongoDB",
          "2": "MySQL",
          "3": "PostgreSQL",
          "4": "SQLite",
        },
        "correctOptionKey": "1",
      },
      "5": {
        "questionText":
            "What is the purpose of middleware in backend frameworks?",
        "options": {
          "1": "To style the webpage",
          "2": "To serve static files",
          "3": "To handle requests between server and database",
          "4": "To define routes",
        },
        "correctOptionKey": "3",
      },
      "6": {
        "questionText": "Which of these is a backend framework for Node.js?",
        "options": {"1": "React", "2": "Vue", "3": "Express", "4": "Angular"},
        "correctOptionKey": "3",
      },
      "7": {
        "questionText":
            "What port does a typical web server run on by default?",
        "options": {"1": "80", "2": "21", "3": "22", "4": "443"},
        "correctOptionKey": "1",
      },
      "8": {
        "questionText":
            "Which protocol is used for secure communication over the web?",
        "options": {"1": "HTTP", "2": "FTP", "3": "HTTPS", "4": "TCP"},
        "correctOptionKey": "3",
      },
      "9": {
        "questionText":
            "What is the role of an ORM (Object Relational Mapper)?",
        "options": {
          "1": "Render HTML pages",
          "2": "Map frontend design",
          "3": "Map objects to database tables",
          "4": "Manage authentication",
        },
        "correctOptionKey": "3",
      },
    },
  },
  "Cloud": {
    "title": "Cloud",
    "image_url":
        "https://www.ibm.com/blogs/blockchain/wp-content/uploads/2020/02/cloud-computing.jpg",
    "questions": {
      "0": {
        "questionText": "What is Cloud Computing?",
        "options": {
          "1": "A new type of web browser",
          "2": "Delivery of computing services over the internet",
          "3": "A backup system for hard drives",
          "4": "Local server networking",
        },
        "correctOptionKey": "2",
      },
      "1": {
        "questionText": "Which company offers AWS?",
        "options": {
          "1": "Microsoft",
          "2": "Google",
          "3": "Amazon",
          "4": "Apple",
        },
        "correctOptionKey": "3",
      },
      "2": {
        "questionText": "What is the purpose of a cloud region?",
        "options": {
          "1": "Increase local RAM",
          "2": "Specify geographic location of data centers",
          "3": "Boost local CPU performance",
          "4": "Provide UI updates",
        },
        "correctOptionKey": "2",
      },
      "3": {
        "questionText": "What does SaaS stand for?",
        "options": {
          "1": "Servers and Storage",
          "2": "Security as a Service",
          "3": "Software as a Security",
          "4": "Software as a Service",
        },
        "correctOptionKey": "4",
      },
      "4": {
        "questionText":
            "Which of the following is a benefit of cloud computing?",
        "options": {
          "1": "Scalability and flexibility",
          "2": "Limited storage",
          "3": "Fixed costs only",
          "4": "Physical access to hardware",
        },
        "correctOptionKey": "1",
      },
      "5": {
        "questionText": "Which of the following is a cloud service model?",
        "options": {"1": "HTTP", "2": "PaaS", "3": "CDN", "4": "VPN"},
        "correctOptionKey": "2",
      },
      "6": {
        "questionText":
            "Which platform is used to deploy applications in containers?",
        "options": {
          "1": "Firebase",
          "2": "Kubernetes",
          "3": "Lambda",
          "4": "Cloudflare",
        },
        "correctOptionKey": "2",
      },
      "7": {
        "questionText": "What is the function of a CDN in cloud services?",
        "options": {
          "1": "Block incoming traffic",
          "2": "Serve dynamic database content",
          "3": "Distribute content closer to users",
          "4": "Manage virtual machines",
        },
        "correctOptionKey": "3",
      },
      "8": {
        "questionText": "What does IaaS stand for?",
        "options": {
          "1": "Information as a System",
          "2": "Internet as a Solution",
          "3": "Infrastructure as a Service",
          "4": "Internal Application Architecture",
        },
        "correctOptionKey": "3",
      },
      "9": {
        "questionText":
            "Which tool is commonly used to manage cloud infrastructure as code?",
        "options": {
          "1": "Terraform",
          "2": "Photoshop",
          "3": "Notion",
          "4": "Postman",
        },
        "correctOptionKey": "1",
      },
    },
  },
};
