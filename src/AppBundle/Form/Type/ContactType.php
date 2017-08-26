<?php

namespace AppBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
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
            ->add('antibot', TextType::class, array(
                'attr' => array(
                    'placeholder'   => 'Combien font 4+3 ?',
                    'style'         => 'width:200px;'
                )
            ))
            ->add('email', EmailType::class, array(
                'attr' => array(
                    'style'         => 'width:200px;'
                )
            ))
            ->add('subject', TextType::class, array(
                'attr' => array(
                    'style'         => 'width:200px;'
                )
            ))
            ->add('message', TextareaType::class, array(
                'attr' => array(
                    'style'         => 'width:500px; height:100px;'
                )
            ))
        ;
    }
}