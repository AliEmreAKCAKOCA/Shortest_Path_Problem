/*********************************************
 * OPL 22.1.1.0 Model
 * Author: AliEmre/OptimalRoute.org
 * Creation Date: 2 Kas 2025 at 23:01:22
 *********************************************/


/** idefine indices  **/
int n = ...;  /** number of nodes **/
           
range N=1..n;  /** range of nodes **/

/** Parameters **/
int c[N][N]=...; /** Cost matrix from excell */
int R[N][N]=...; /** Relation matrix from excel' desccribe on .dat file' */


/** Decision variable **/
dvar float+ X[N][N];  /** binary X[][] decision variable**/

 /** Goal Function **/
minimize sum(i in N, j in N) c[i][j]*X[i][j]; 
subject to
{
forall (i in N: i!=1 && i!=n ) 
	sum(k in N) R[k][i]*X[k][i] == sum(j in N) R[i][j]*X[i][j];  	/**Constraint,  that visits a nodemust leave the same nodefor (except 1 and n) **/
	
sum(j in N) R[1][j]*X[1][j] ==1;  	/** constraint ensure that starts its route from the 1. node **/
	
sum(k in N) R[k][n]*X[k][n] ==1;   /* This constraint ensures that node n must be entered only once */

forall(i in N, j in N) 0<=X[i][j]<=1; // This feature was actually defined above as dvar binary, if you choose dvar int or int+, you can use. This constraint will probably increase the solution time now. 

}


// log
execute DISPLAY{
	write("shortest path : 1 " )
		var route = 1;
			while(route !=n){
				for(i in N){
					if(X[route][i] == 1) {
						write(" --> ", i);
						route = i;
						break;
					}
 				}
			} 	
		}
 