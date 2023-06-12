import string
a_chars = list(string.ascii_lowercase) # available chars
taille = int(input())
cote = int(taille*2)-1
cote2 = cote
chars = []
for i in range(cote):
   # on regarde si on est à la 1ere moitié ou non
   if i<taille:
      chars.append(a_chars[i])
   else:
       del chars[-1]
   str_to_print = ''
   
   # première moitié de la ligne
   for j in range(taille):
       if a_chars[j] in chars:
           str_to_print+=a_chars[j]
       else:
           str_to_print+=chars[-1]

   # deuxieme moitié
   for k in range(taille-2, -1, -1):
       if a_chars[k] in chars:
           str_to_print+=a_chars[k]
       else:
           str_to_print+=chars[-1]
   #print(chars)
   
   print(str_to_print)
