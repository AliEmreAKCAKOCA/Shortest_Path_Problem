/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Banusoylu
 * Creation Date: 6 Nis 2021 at 12:12:42
 *********************************************/
/** indisler tanýmlanýr  **/
int n = 5;  /** düðüm sayýsý **/
            /** baðlantýlarýn sayýsýný vermeye gerek yok, node-node komþuluk matrisinden katsayýsý 1 olanlarý alacak**/

range N=1..n;  /* düðümler kümesi **/


/** parametreler tanýmlanýr **/
int c[N][N]=...; /** maliyet matrisi, dat dosyasýnda excel'den çekilecek */
int H[N][N]=...; /** node-node komþuluk matrisi, dat dosyasýndan excel'den çekilecek */
/** karar deðiþkenleri tanýmlanýr **/
/** float, float+, boolean, int olabilir. 
    float, free deðiþken,
    float+ >=0 sürekli deðiþken,
    boolean, {0,1} binary deðiþken,
    int tamsayýlý deðiþken    **/

dvar float+ X[N][N];  /** binary X[][] decision variable (karar deðiþkeni) tanýmlandý**/

 /** Model yazýlýr **/

minimize sum(i in N, j in N) c[i][j]*X[i][j];  /** amaç fonksiyonu  */ 
subject to
{
forall (i in N: i!=1 && i!=n ) 
	sum(k in N) H[k][i]*X[k][i] == sum(j in N) H[i][j]*X[i][j];  /* 1 ve n hariç ara düðümlere girenler=çýkanlar */
	
sum(j in N) H[1][j]*X[1][j] ==1;  /* Düðüm 1'den sadece 1 çýkýþ olmalý */
	
sum(k in N) H[k][n]*X[k][n] ==1;   /* Düðüm n'ye sadece 1 giriþ olmalý */

forall(i in N, j in N) 0<=X[i][j]<=1;
}


// Optimal çözümü özetlemek için kullanabilirsiniz. Komut modülünden görebilirsiniz.
execute DISPLAY{
	write("En kýsa Yol þu þekildedir : 1 " )
		var siradaki = 1;
			while(siradaki !=n){
				for(i in N){
					if(X[siradaki][i] == 1) {
						write(" --> ", i);
						siradaki = i;
						break;
					}
 				}
			} 	
		}
