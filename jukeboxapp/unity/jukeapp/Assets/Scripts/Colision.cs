using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Colision : MonoBehaviour
{
    public GameObject explosion;
    // Start is called before the first frame update
    void Start()
    {

    }

    void OnCollisionEnter(Collision collision)
    {
        Instantiate(explosion,transform.position,collision.transform.rotation);
        Destroy(gameObject, .02f);

    }
    void Update()
    {
        Destroy(gameObject,3);
    }
}
