using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Colision : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {

    }

    void OnCollisionEnter(Collision collision)
    {

        Destroy(gameObject);

    }
    void Update()
    {
        Destroy(gameObject,3);
    }
}
