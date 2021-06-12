# Kalman Filter Application 
Objective to Implement a linear kalman Filter in python with an example.\
\
The Kalman Filter is a derived from the Family of Gaussian Filters which was invented by swerling in 1958 ti study the filtering and prediction on linear Gaussian Systems.The output of the KF is a belief vector for continuos time systems. It is not applicable to discrete or Hybrid State Spaces.*The Kalman filter represents beliefs by the moments parameterization: At
time t, the belief is represented by the the mean μt and the covariance Σt.*\
\
GAUSSIAN POSTERIOR Posteriors are Gaussian if the following three properties hold, in addition tothe Markov assumptions of the Bayes filter.\

![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/1.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/2.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/3.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/4.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/5.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/6.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/7.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/6.1.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/8.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/9.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/10.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/11.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/algo.jpg)
\
![Kalman Filter Algorithm](https://github.com/starceees/starceees/blob/main/KF/algorithm.jpg)

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
import numpy as np
from numpy.linalg import inv

x_observations = np.array([4000, 4260, 4550, 4860, 5110]) #Distance Values of THe aircraft
v_observations = np.array([280, 282, 285, 286, 290]) #velocity of the aircraft at the given distance

z = np.c_[x_observations, v_observations]

# Initial Conditions
a = 2  # Acceleration
v = 280
t = 1  # Difference in time

# Process / Estimation Errors
error_est_x = 20  #error in sensor during measurement
error_est_v = 5

# Observation Errors
error_obs_x = 25  # Uncertainty in the measurement
error_obs_v = 6

def prediction2d(x, v, t, a):
    A = np.array([[1, t],
                  [0, 1]])
    X = np.array([[x],
                  [v]])
    B = np.array([[0.5 * t ** 2],
                  [t]])
    X_prime = A.dot(X) + B.dot(a)
    return X_prime


def covariance2d(sigma1, sigma2):
    cov1_2 = sigma1 * sigma2
    cov2_1 = sigma2 * sigma1
    cov_matrix = np.array([[sigma1 ** 2, cov1_2],
                           [cov2_1, sigma2 ** 2]])
    return np.diag(np.diag(cov_matrix))


# Initial Estimation Covariance Matrix
P = covariance2d(error_est_x, error_est_v)
A = np.array([[1, t],
              [0, 1]])

# Initial State Matrix
X = np.array([[z[0][0]],
              [v]])
n = len(z[0])

for data in z[1:]:
    X = prediction2d(X[0][0], X[1][0], t, a)
    # To simplify the problem, professor
    # set off-diagonal terms to 0.
    P = np.diag(np.diag(A.dot(P).dot(A.T)))

    # Calculating the Kalman Gain
    H = np.identity(n)
    R = covariance2d(error_obs_x, error_obs_v)
    S = H.dot(P).dot(H.T) + R
    K = P.dot(H).dot(inv(S))

    # Reshape the new data into the measurement space.
    Y = H.dot(data).reshape(n, -1)

    # Update the State Matrix
    # Combination of the predicted state, measured values, covariance matrix and Kalman Gain
    X = X + K.dot(Y - H.dot(X))

    # Update Process Covariance Matrix
    P = (np.identity(len(K)) - K.dot(H)).dot(P)
print("Expected postion and velocity of the aircraft the the current time")
print("Kalman Filter State Matrix:\n", X)
~~~
