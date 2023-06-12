nb_mesures = int(input())
diff_max = float(input())

def test_lisse(l):
   lisse = True
   for i in range(1, len(l)):
      if abs(l[i-1]-l[i]) > diff_max:
         lisse = False
   return lisse
 
mesures = list()
for i in range(nb_mesures):
   mesures.append(float(input()))

liss_max = 0

while not test_lisse(mesures):   
   lisse = False
   print(f'{liss_max} mesures')
   for i in range(1, len(mesures)-1):
      if abs(mesures[i-1] - mesures[i]) > diff_max and lisse==False:
         print(f'on lisse {mesures[i]} entre {mesures[i-1]} et {mesures[i+1]} en {(mesures[i-1]+mesures[i+1])/2}')
         liss_max+=1
         mesures[i] = (mesures[i-1]+mesures[i+1])/2
         lisse = True
print(liss_max)
