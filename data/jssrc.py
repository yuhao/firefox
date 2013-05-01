from HTMLParser import HTMLParser
from htmlentitydefs import name2codepoint
import sys

class MyHTMLParser(HTMLParser):
	def handle_starttag(self, tag, attrs):
		if(tag == "script"):
			for attr in attrs:
				if(attr[0] == "src"):
					print attr[1];

parser = MyHTMLParser()
parser.reset();
site_name = sys.argv[1];
site_html = open(site_name, "r");
while 1:
    line = site_html.readline();
    #print line;
    if not line: break;
    try: parser.feed(line);
    except: parser.reset();

