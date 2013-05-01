from HTMLParser import HTMLParser
from htmlentitydefs import name2codepoint
import sys

class MyHTMLParser(HTMLParser):
	def handle_starttag(self, tag, attrs):
		if(tag == "a"):
			for attr in attrs:
					if(attr[0] == "href"):
						print attr[1]


    #def handle_endtag(self, tag):
    #    print "End tag  :", tag
    #def handle_comment(self, data):
    #    print "Comment  :", data
    #def handle_entityref(self, name):
    #    c = unichr(name2codepoint[name])
    #    print "Named ent:", c
    #def handle_charref(self, name):
    #    if name.startswith('x'):
    #        c = unichr(int(name[1:], 16))
    #    else:
    #        c = unichr(int(name))
    #    print "Num ent  :", c
    #def handle_decl(self, data):
    #    print "Decl     :", data

flag = 0;
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

