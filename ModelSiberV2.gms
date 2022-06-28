sets
   i ana stratejiler
     /1,2,3/
   j alt stratejiler risk kategorileri
     /1,2,3/
   k risk kategorileri
     /1,2,3,4,5,6/
;

Parameters
   p(i,j,k)  i ana stratejisine ait j alt stratejisinin k risk kategorisini önleme derecesi
             /  1.1.1 43.33, 1.1.2 53.33, 1.1.3 51.67, 1.1.4 51.67, 1.1.5 48.33, 1.1.6 58.33
                1.2.1 71.67, 1.2.2 75.00, 1.2.3 78.33, 1.2.4 71.67, 1.2.5 63.33, 1.2.6 71.67
                1.3.1 86.67, 1.3.2 95.00, 1.3.3 91.67, 1.3.4 91.67, 1.3.5 81.67, 1.3.6 93.33

                2.1.1 33.33, 2.1.2 28.33, 2.1.3 40.00, 2.1.4 45.00, 2.1.5 36.67, 2.1.6 30.00
                2.2.1 58.33, 2.2.2 63.33, 2.2.3 70.00, 2.2.4 70.00, 2.2.5 58.33, 2.2.6 60.00
                2.3.1 90.00, 2.3.2 90.00, 2.3.3 91.67, 2.3.4 95.00, 2.3.5 86.67, 2.3.6 88.33

                3.1.1 21.67, 3.1.2 21.67, 3.1.3 23.33, 3.1.4 23.33, 3.1.5 25.00, 3.1.6 16.67
                3.2.1 45.00, 3.2.2 48.33, 3.2.3 53.33, 3.2.4 36.67, 3.2.5 51.67, 3.2.6 45.00
                3.3.1 86.67, 3.3.2 88.33, 3.3.3 71.67, 3.3.4 68.33, 3.3.5 86.67, 3.3.6 73.33
             /
   H(i,k)   i ana stratejisinin k risk kategorisinde hedeflenen önlenme derecesi
            / 1.1 100, 1.2 100, 1.3 100, 1.4 100, 1.5 100, 1.6 100
              2.1 100, 2.2 100, 2.3 100, 2.4 100, 2.5 100, 2.6 100
              3.1 100, 3.2 100, 3.3 100, 3.4 100, 3.5 100, 3.6 100
            /

   C(i,j)   i ana stratejisine ait j alt stratejisinin maliyeti
           /1.1 40, 1.2 60, 1.3 90
            2.1 30, 2.2 50, 2.3 70
            3.1 20, 3.2 30, 3.3 40
           /

   B      siber güvenliðin artirilmasi için ayrilan kaynak miktari
          /190/
;

binary variables
    x(i,j) i ana stratejisine ait j alt stratejisinin uygulanýp uygulanmayacaðý
positive variables
    d(i,k) i ana stratejisinin j risk kategorisinde hedeflenen önlenme derecesinden sapma miktari
;
variables
    Z    amac fonksiyonu degeri (hedeflerden toplam sapma miktari)
;
equations
    ObjF, Target(i,k), Budget, OneSubStrtgy(i)
;
ObjF..
       Z=e=sum((i,k), d(i,k))
;

Target(i,k)..
       sum(j,p(i,j,k)*x(i,j)) =G= H(i,k)-d(i,k)
;

Budget..
     sum((i,j),C(i,j)*x(i,j))=L= B
;
OneSubStrtgy(i)..
       sum(j,x(i,j))=L= 1
;
model Siber /all/;
solve Siber using  MIP minimizing Z;
display x.l, d.l;
