DRL es difícil de aplicar para aplicaciones safety-critical debido a su poca fiabilidad. Por lo que se ha intentado proveerle de garantías formales de [[Safety]] 

Algunos de los métodos usados son:
- [[RL Shielding]]: Componente externo online que valida la salida RL, computacionalmente costoso
- [[RL Verification]]: Proceso offline que identifica políticas unsafe, pero no aporta opciones alternativas a estas.
- [[Verification-guided shielding]]:

Algoritmos normales de DRL tratan de optimizar expected cumulative reward, que es el objetivo principal del agente. Para SDRL es comun introducir una nueva funcion que representa las restricciones de safety  