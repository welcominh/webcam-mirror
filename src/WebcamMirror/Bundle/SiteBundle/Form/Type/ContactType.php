<?php

namespace WebcamMirror\Bundle\SiteBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;

class ContactType extends AbstractType
{
    public function getName()
    {
        return 'contact';
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('antibot', 'text', array(
                'attr' => array(
                    'placeholder'   => 'Combien font 4+3 ?',
                    'style'         => 'width:200px;'
                )
            ))
            ->add('email', 'email', array(
                'attr' => array(
                    'style'         => 'width:200px;'
                )
            ))
            ->add('subject', 'text', array(
                'attr' => array(
                    'style'         => 'width:200px;'
                )
            ))
            ->add('message', 'textarea', array(
                'attr' => array(
                    'style'         => 'width:500px; height:100px;'
                )
            ))
        ;
    }
}