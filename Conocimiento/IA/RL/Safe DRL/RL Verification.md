## DNN-Verification Problem
Input: R = ⟨N , P, Q⟩, where N is a DNN, P is a precondition on the DNN’s inputs, and Q is a postcondition on the DNN’s outputs. 
Output: SAT if ∃ x | P(x) ∧ Q(N (x)), and UNSAT otherwise.

P en general es conocimiento del dominio. Q es la negacion de los estados deseados.  El problema fue probado que es NP-completo