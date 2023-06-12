def get_d(d):
   # on récupère les données initiales
   get_d1 = True # on a que deux données a récupéré, séparées par un espace
   d1 = ''
   d2 = ''
   for char in d:
       if char == ' ':
          get_d1 = False
       else:
          if get_d1:
             d1+=char
          else:
             d2+=char
   return [int(d1), int(d2)]

donnees = get_d(input())
nbLivres, nbJours = donnees[0], donnees[1]

# bibliothèque
bibli = dict()
for i in range(nbLivres):
   bibli[i] = 0 # key : book index   value : time before available
   
for jour in range(nbJours):
   nbClients = int(input())
   
   for client in range(nbClients):
      donnees = get_d(input())
      i_livre, time_livre = donnees[0], donnees[1]
      if bibli[i_livre] == 0 :
         # ON PEUT EMPRUNTER
         bibli[i_livre] = time_livre
         print('1')
      else:
         # ON PEUT PAS EMPRUNTER
         print('0')
   
   # nouveau jour
   for key in list(bibli.keys()):
      if bibli[key] > 0:
         # on descend le compteur d'emprunt de 1
         bibli[key] = bibli[key]-1
