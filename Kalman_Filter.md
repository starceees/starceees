# Kalman Filter Application 
Objective to Implement a linear kalman Filter in python with an example.\
\
The Kalman Filter is a derived from the Family of Gaussian Filters which was invented by swerling in 1958 ti study the filtering and prediction on linear Gaussian Systems.The output of the KF is a belief vector for continuos time systems. It is not applicable to discrete or Hybrid State Spaces.*The Kalman filter represents beliefs by the moments parameterization: At
time t, the belief is represented by the the mean μt and the covariance Σt.*\
\
GAUSSIAN POSTERIOR Posteriors are Gaussian if the following three properties hold, in addition tothe Markov assumptions of the Bayes filter.\
![Kalman Filter Algorithm](https://drive.google.com/file/d/1V8nkJB-lmgGgiRqVAWjD7OIEN7FuCT9E/view?usp=sharing)


\ ~~~
<span style="color:lightblue">
## Instance Variables

You will have to assign reasonable values to all of these before running the filter. All must have dtype of float.
\
* **x** : ndarray (dim_x, 1), default = [0,0,0…0]
filter state estimate
* **P** : ndarray (dim_x, dim_x), default eye(dim_x)
covariance matrix
* **Q** : ndarray (dim_x, dim_x), default eye(dim_x)
Process uncertainty/noise 
* **R** : ndarray (dim_z, dim_z), default eye(dim_x)
measurement uncertainty/noise 
 * **H** : ndarray (dim_z, dim_x)
measurement function
* **F** : ndarray (dim_x, dim_x)
state transistion matrix
* **B** : ndarray (dim_x, dim_u), default 0
control transition matrix

### Optional Instance Variables

* **alpha** : float\
Assign a value > 1.0 to turn this into a fading memory filter.\
</span>
~~~
~~~
<span style ="color:pink">
## Read-only Instance Variables

* **K** : ndarray
>* Kalman gain that was used in the most recent update() call.
* **Y** : ndarray
>* Residual calculated in the most recent update() call. I.e., the different between the measurement and the current estimated state projected into measurement space (z - Hx)
* **S** : ndarray
>* System uncertainty projected into measurement space. I.e., HPH’ + R. Probably not very useful, but it is here if you want it.
* likelihood : float
Likelihood of last measurment update.\
log_likelihood : float\
Log likelihood of last measurment update.
</span>
~~~
![Kalman Filter Algorithm](/home/raghu/KF/algorithm.png)
